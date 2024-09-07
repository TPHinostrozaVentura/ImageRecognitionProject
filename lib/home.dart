import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:recognition/objectDetectionPage.dart';

class Home extends StatefulWidget {
  //const Home({super.key});
  final List<CameraDescription> cameras;

  //const Home({Key? key}) : super(key: key);
  const Home({Key? key, required this.cameras}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Imagen de fondo con desplazamiento a la izquierda
            Positioned.fill(
              child: Transform.translate(
                offset: const Offset(0.0, 0.0), // Mueve la imagen 20 píxeles a la izquierda
                child: Image.asset(
                  'assets/blindimg2.jpeg', // Asegúrate de tener la imagen en la carpeta assets
                  fit: BoxFit.cover,
                  //alignment: Alignment.topRight,
                ),
              ),
            ),
            // Contenido de la pantalla
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Botones centrales
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                      children: <Widget>[
                        SizedBox(
                          width: 250, // Ancho del botón
                          height: 140, // Alto del botón
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black.withOpacity(0.7), // Color gris con opacidad
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Bordes redondeados
                              ),
                            ),
                            onPressed: () {
                              // Acción para Guía de Uso
                            },
                            child: const Text(
                              'Guía de Uso',
                              style: TextStyle(fontSize: 30), // Texto grande
                            ),
                          ),
                        ),
                        const SizedBox(height: 90), // Espacio entre los botones
                        SizedBox(
                          width: 250,
                          height: 140,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black.withOpacity(0.7), // Color gris con opacidad
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              // Acción para Iniciar
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) {
                                return ObjectDetectionPage(cameras: widget.cameras);
                              },)
                              );
                            },
                            child: const Text(
                              'Iniciar',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Botones inferiores
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          // Acción para Home
                        },
                        icon: const Icon(Icons.home),
                        iconSize: 40,
                      ),
                      IconButton(
                        onPressed: () {
                          // Acción para Ir Atrás
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
