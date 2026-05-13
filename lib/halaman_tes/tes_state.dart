import 'package:flutter/material.dart';

class TesState extends StatefulWidget {
  const TesState({super.key});

  @override
  State<TesState> createState() => _TesStateState();
}

class _TesStateState extends State<TesState> {

  int tambah = 0;
  bool isUbah = true;
  bool isIcon = true;
  bool isFont = false;
  bool isBackAtas = false;
  bool isBackBawah = false;



  void tambahangka (){
    setState(() {
      if (tambah<10)
      tambah++;
    }
    );
  }
  void kurangangka () {
    setState(() {
      if (tambah>0)
      tambah--;
    }
    );
  } //set sta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUbah? "Tambah kurang" : "Kurang Tambah"),
        centerTitle: true,
        backgroundColor: isBackAtas? Colors.amber : Colors.blue,),
        body: Column(
          children: [
            SizedBox(height: 50,),
            Text('$tambah'),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  tambahangka();
                }, child: Text('tambah')),

                SizedBox(width: 50,),

                ElevatedButton(onPressed: (){
                  kurangangka();
                }, child: Text('kurang')),
              ],
            ),

            SizedBox(height: 20,),

            Text("Hallo Coy",
            style: TextStyle(
              fontSize: isUbah? 20 : 50,
              fontFamily: isFont? 'blacklane' : 'Super'
            ),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    isUbah = !isUbah;
                  });
                }, child: Text("ukuran")),

                ElevatedButton(onPressed: (){
                  setState(() {
                    isFont = !isFont;
                  });
                }, child: Text("font")),

                ElevatedButton(onPressed: (){
                  setState(() {  
                    isBackAtas = !isBackAtas;
                  });
                }, child: Text("atas")),

                ElevatedButton(onPressed: (){
                  setState(() {
                    isBackBawah = !isBackBawah;
                  });
                }, child: Text("bawah")),
              ],
            ),

            SizedBox(height: 20,),

            IconButton(onPressed: (){
              setState(() {
                isIcon = !isIcon;
              });
            }, icon: Icon(isIcon? Icons.abc : Icons.ac_unit),
            iconSize: 50,)
          ],
        ),
        backgroundColor: isBackBawah? Colors.black : Colors.white,
    );
  }
}