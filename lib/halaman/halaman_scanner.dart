import 'package:flutter/material.dart';
import 'package:magang_yusuf/halaman/halaman_form_rank.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanScanner extends StatefulWidget {

  final Function(String) onScan;

  const HalamanScanner({
    super.key,
    required this.onScan,
  });

  @override
  State<HalamanScanner> createState() =>
      _HalamanScannerState();
}

class _HalamanScannerState
    extends State<HalamanScanner> {

  String? hasilScan;

  bool scanned = false;
  bool hasCameraPermission = false;

  Future<void> requestCameraPermission() async {

  final status = await Permission.camera.request();

  print("CAMERA STATUS:");
  print(status);

  if (status.isGranted) {

    setState(() {

      hasCameraPermission = true;

    });

  } 
  
  else if (status.isPermanentlyDenied) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: const Text(
          "Permission kamera ditolak permanen",
        ),

        action: SnackBarAction(

          label: "Settings",

          onPressed: () {

            openAppSettings();
          },
        ),
      ),
    );
  } 
  
  else {

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Permission kamera ditolak",
        ),
      ),
    );
  }
}

  final MobileScannerController controller =
      MobileScannerController(
    facing: CameraFacing.back,
  );

  @override
void initState() {

  super.initState();

  requestCameraPermission();
}

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Scanner"),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            SizedBox(

              width: 300,
              height: 300,

              child: hasCameraPermission

                    ? MobileScanner(

                         controller: controller,

                        onDetect: (capture) async {

                          if (scanned) return;

                          final code =
                              capture.barcodes.first.rawValue;

                          if (code != null) {

                            scanned = true;

                            print("HASIL SCAN:");
                            print(code);

                            setState(() {

                              hasilScan = code;

                            });

                            // QR KHUSUS
                            if (
                              code.trim() ==
                              "MOBILE_LEGEND_BANG_BANG"
                            ) {

                              await controller.stop();

                              if (!mounted) return;

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      const HalamanFormRank(),
                                ),
                              ).then((_) async {

                                await controller.start();

                                scanned = false;
                              });
                            }

                            // QR URL
                            else if (
                              code.startsWith("http")
                            ) {

                              final url = Uri.parse(code);

                              await launchUrl(

                                url,

                                mode:
                                    LaunchMode
                                        .externalApplication,
                              );
                            }
                          }

                          await Future.delayed(
                            const Duration(seconds: 2),
                          );

                          scanned = false;
                        },
                      )

                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
            ),

            const SizedBox(height: 20),

            const Text(

              "Scan QR",

              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            if (hasilScan != null)
              Text(

                hasilScan!,

                style: const TextStyle(
                  color: Colors.amber,
                ),
              ),
          ],
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {

          controller.switchCamera();
        },

        child: const Icon(
          Icons.cameraswitch,
        ),
      ),
    );
  }
}