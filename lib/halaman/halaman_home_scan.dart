import 'package:flutter/material.dart';
import 'halaman_scanner.dart';

class HalamanHomeScan extends StatefulWidget {
  const HalamanHomeScan({super.key});

  @override
  State<HalamanHomeScan> createState() =>
      _HalamanHomeScanState();
}

class _HalamanHomeScanState
    extends State<HalamanHomeScan> {

  String hasil = "-";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Scanner"),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Text(hasil),

            ElevatedButton(

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => HalamanScanner(

                      onScan: (code) {

                        setState(() {

                          hasil = code;

                        });

                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },

              child: const Text(
                "Scan Barcode",
              ),
            ),
          ],
        ),
      ),
    );
  }
}