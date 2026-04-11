import 'package:flutter/material.dart';

class TextDanField extends StatefulWidget {
  const TextDanField({super.key});

  @override
  State<TextDanField> createState() => _TextDanFieldState();
}

class _TextDanFieldState extends State<TextDanField> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Text Field"
          )
          ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            // Fitur
            // autocorrect: false, //auto koreksi
            // autofocus: false, //otomatis diminta mengisi tanpa klik dulu
            // enableInteractiveSelection: false, //copy and paste
            // obscureText: false, //text bintang (buat sandi atau password)
            // obscuringCharacter: "*", //karakter obsure
            // keyboardType: TextInputType.phone, //keyboard menampilkan number saja

            // showCursor: true, //icon "|" kedip-kedip
            // textAlign: TextAlign.start, //posisi input text
            // textCapitalization: TextCapitalization.words, //text kapital di awal kata
            // style: TextStyle( //style fontnya
            //   color: Colors.redAccent,
            //   fontSize: 20,
              
            decoration: InputDecoration(
              icon: Icon(Icons.person
              ),
              border: OutlineInputBorder(), //border
              hintText: "harus ada isinya cuy", //text ketika di klik ilang
              labelText: "nama"
            ),
            ),
          ),
        ),
      );
  }
}