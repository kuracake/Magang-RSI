import 'package:flutter/material.dart';
import 'package:magang_yusuf/halaman_tes/home.dart';
import 'package:magang_yusuf/halaman_tes/shared_screen.dart';

import 'halaman_session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  Future<void> cekSession() async {
    await Future.delayed(const Duration(seconds: 1));

    bool ada = await Session.adaSharedKah();

    if (ada) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SharedScreen()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/gambar/ic_youtube.png", width: 160,),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              cekSession();
            }, child: Text("KLIK UNTUK LOAD"))
          ],
        ),
      ),
    );
  }
}