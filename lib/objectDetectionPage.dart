import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class ObjectDetectionPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ObjectDetectionPage({required this.cameras});

  @override
  State<ObjectDetectionPage> createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends State<ObjectDetectionPage> {

  late CameraController _cameraController;
  bool _isDetecting = false;
  List<dynamic>? _recognitions;
  String? _detectedObjectName = '';
  int _imageWidth = 0;
  int _imageHeight = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  void _initializeCamera() {
    _cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _cameraController.startImageStream((CameraImage img) {
        if (!_isDetecting) {
          _isDetecting = true;

          // Procesar la imagen y detectar objetos
          Tflite.runModelOnFrame(
            bytesList: img.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: img.height,
            imageWidth: img.width,
            imageMean: 127.5,
            imageStd: 127.5,
            rotation: 90,
            numResults: 2,
            threshold: 0.5,
          ).then((recognitions) {
            setState(() {
              _recognitions = recognitions;
              if (_recognitions != null && _recognitions!.isNotEmpty) {
                _detectedObjectName = _recognitions![0]['label'];
              }
              _imageWidth = img.width;
              _imageHeight = img.height;
            });
            _isDetecting = false;
          });
        }
      });
    });
  }

  // Cargar el modelo de TensorFlow Lite
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/mobilenet_v1_1.0_224.tflite',
      labels: 'assets/mobilenet_v1_1.0_224.txt',
      numThreads: 1,
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Object Detection Real-Time'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _cameraController.value.isInitialized
                ? CameraPreview(_cameraController)
                : Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.black,
            width: double.infinity,
            child: Text(
              _detectedObjectName ?? 'Detectando...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
