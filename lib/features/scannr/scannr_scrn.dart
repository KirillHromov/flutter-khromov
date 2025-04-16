import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannrScrn extends StatefulWidget {
  const ScannrScrn({Key? key}) : super(key: key);

  @override
  _ScannrScrnState createState() => _ScannrScrnState();
}

class _ScannrScrnState extends State<ScannrScrn> {
  MobileScannerController cameraController = MobileScannerController();
  String? qrResult;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Дай доступ к камере ваше высочество',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Сканируй QR, мой король'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  setState(() {
                    qrResult = barcodes.first.rawValue;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Найден QR: $qrResult')),
                  );
                }
              },
            ),
          ),
          if (qrResult != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Результат: $qrResult',
                style: const TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
