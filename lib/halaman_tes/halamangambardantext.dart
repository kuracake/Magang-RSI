import 'package:flutter/material.dart';

class GambarDanText extends StatefulWidget {
  const GambarDanText({super.key});

  @override
  State<GambarDanText> createState() => _GambarDanTextState();
}

class _GambarDanTextState extends State<GambarDanText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gambar dan Text'),
        titleTextStyle: TextStyle(
        fontStyle: FontStyle.normal,
        fontFamily: 'Super',
        fontSize :30,  
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 20,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Text (
                        'magang',
                      style: TextStyle(
                        fontFamily: 'Blacklane',
                        fontSize: 50, 
                      ),
            
                      ),
                      SizedBox(width: 20,),
                      Text (
                        'yusuf',
                        style: TextStyle(
                          fontFamily: 'Super',
                          fontSize: 50,
                        ),
                      ),
                    ],
              ),
              
            ),

            Center(
                child: Image.network("https://www.quipper.com/id/blog/wp-content/uploads/2023/01/pexels-pixabay-36753.webp"),
                ),
            Center(
                child: Image.asset("asset/images/bunga.jpg",
                width: 150,
                height: 150, 
                ),

                ),
            SizedBox(height: 50,),
            Center(
                child: Image.asset("asset/images/vasbunga.jpg",
                width: 450,
                height: 450,
                ),
                ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('bunga'),
                        duration: Duration(seconds: 2)
                          )
                          );
                  },
                  child: Text('lihat bunga'
                  )
                  ),
                ElevatedButton(
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('vas bunga'),
                        duration: Duration(seconds: 2)
                          )
                          );
                  },
                  child: Text('lihat vas bunga'
                  )
                  ),
              ],
            ),
            SizedBox(height: 20,)
            ],
        ),
      ),
    );
  }
}