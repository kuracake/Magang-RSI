import 'package:flutter/material.dart';
import 'package:magang_yusuf/halaman_session.dart';
import 'package:magang_yusuf/halaman_tes/shared_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  void konfirmasiHapus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Yakin ingin menghapus data?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                await Session.hapusShared();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SharedScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          konfirmasiHapus(context);
        }, child: Text("HAPUS DATA SHARED")),
      ),
    );
  }
}