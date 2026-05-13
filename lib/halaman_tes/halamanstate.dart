import 'package:flutter/material.dart';

class HalamanState extends StatefulWidget {
  const HalamanState({super.key});

  @override
  State<HalamanState> createState() => _HalamanStateState();
}

class _HalamanStateState extends State<HalamanState> {


  int tambah = 0;
  void tambahangka () {
    setState(() {
      tambah++;
    }
    );
  }
  void kurangangka () {
    setState(() {
      tambah--;
    }
    );
  } //set state integer

  String teks = 'hallo';
  void berubahteks (){
    setState(() {
       teks = (teks == "Hallo") ? "Hai" : "Hallo";
    }
    );
  } //set state string

  bool tampil = true;
  void ubahstatus (){
    setState(() {
      tampil=!tampil;
    });
  } //set state boolean

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman State',
        ),
        backgroundColor: tampil? Colors.blue : Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              '$tambah',
              style: TextStyle(
                fontSize: 30,
              ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  kurangangka();
                }, child: Text(
                  'kurang',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  )
                  ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(onPressed: (){
                  tambahangka();
                }, child: Text(
                  'tambah',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  )
                  )
                ],
              ),
            SizedBox(
              height: 20,
            ),
              Text('$teks',
              style: TextStyle(
                fontSize: 20,
              ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (){
                berubahteks();
              }, child: Text(
                'berubah',
                style: TextStyle(
                  fontSize: 20,
                ),
                )
                ),
                SizedBox(
                  height: 20,
                ),
                
                Text('$tampil',
                style: TextStyle(
                  fontSize: 20,
                  color: tampil? Colors.white : Colors.black
                ),
                ),

              ElevatedButton(onPressed: (){
                ubahstatus();
              }, child: Text(
                'berubah'
              ))
            ],
          ),
        ),
        backgroundColor: tampil? Colors.amber : Colors.blue,
      );
    }
  }