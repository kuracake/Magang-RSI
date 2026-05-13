import 'package:flutter/material.dart';

class HalamanBaru extends StatefulWidget {
  final String TesPassing;

   HalamanBaru({super.key, required this.TesPassing});

  @override
  State<HalamanBaru> createState() => _HalamanBaruState();
}

class _HalamanBaruState extends State<HalamanBaru> {

  final List<String> icon = [
    'asset/icons/instagram.png',
    'asset/icons/tiktok.png',
    'asset/icons/twitter.png',
    'asset/icons/whatsapp.png',
  ];

  final List<Map<String,dynamic>> nama = [
    { 'judul': 'instagram', 'icon': 'asset/images/icons/instagram.png'},
    { 'judul': 'tiktok', 'icon': 'asset/images/icons/tiktok.png'},
    { 'judul': 'twitter', 'icon': 'asset/images/icons/twitter.png'},
    { 'judul': 'whatsapp', 'icon': 'asset/images/icons/whatsapp.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.TesPassing),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: icon.length,
              itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${nama[index]['judul']}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                    child: Row(
                      children: [
                        Image.asset(
                          nama[index]['gambar'],
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          nama[index]['judul']
                        ),
                        Expanded(child: Icon(Icons.people))
                      ],
                    ),

                  );
                },),
          )
        ],
      ),
    );
  }
}