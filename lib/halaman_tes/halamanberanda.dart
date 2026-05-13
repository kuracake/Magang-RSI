import 'package:flutter/material.dart';
import '../halaman/halaman_baru.dart';

class HomeHome extends StatefulWidget {
  const HomeHome({super.key});
  @override
  State<HomeHome> createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {

  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Beranda'),
        backgroundColor: Colors.amber,
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
          context,
            MaterialPageRoute(
             builder: (context) =>  HalamanBaru(
              TesPassing: 'aku kripto'
              ),
             ),
             );
      }, child: Icon(Icons.add_a_photo)),
    );
  }
}