import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("3D Model Viewer")),
        body: ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          // Gunakan URL Astronaut ini sementara
          src: 'assets/damaged-helmet.glb',
          alt: 'Model 3D Astronaut',
          cameraControls: true,
        ),
      ),
    );
  }
}
