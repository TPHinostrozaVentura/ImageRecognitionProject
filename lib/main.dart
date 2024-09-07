import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:recognition/home.dart';
import 'package:recognition/objectDetectionPage.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar cámaras disponibles
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({required this.cameras});
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Home(cameras:cameras),
      //home: ObjectDetectionPage(cameras:cameras),
    );
  }
}