import 'package:flutter/material.dart';

class HalamanList extends StatefulWidget {
  const HalamanList({super.key});

  @override
  State<HalamanList> createState() => _HalamanListState();
}

class _HalamanListState extends State<HalamanList> {

  final List<String> icon = [
    'https://images.icon-icons.com/4518/PNG/512/274861_upward-arrow-icon.png',
    'https://images.icon-icons.com/4518/PNG/512/274860_play-video-icon.png',
    'https://images.icon-icons.com/4518/PNG/512/274859_add-user-icon.png',
    'https://images.icon-icons.com/4518/PNG/512/274858_live-badge-icon.png'
  ];

  final List<String> gambar = [
    'asset/images/icons/instagram.png',
    'asset/images/icons/tiktok.png',
    'asset/images/icons/twitter.png',
    'asset/images/icons/whatsapp.png'
  ];

  final List<Map<String,dynamic>> nama = [
    { 'judul': 'instagram', 'gambar': 'asset/images/icons/instagram.png'},
    { 'judul': 'tiktok', 'gambar': 'asset/images/icons/tiktok.png'},
    { 'judul': 'twitter', 'gambar': 'asset/images/icons/twitter.png'},
    { 'judul': 'whatsapp', 'gambar': 'asset/images/icons/whatsapp.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman List'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal, 
              itemCount: icon.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    icon[index],
                    width: 100,
                    height: 100,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 50, height: 50, 
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          Expanded( 
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 15, 
                mainAxisSpacing: 15, 
              ),
              itemCount: gambar.length,
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
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      // Memanggil gambar dari Asset Lokal
                      child: Image.asset(
                        nama[index]['gambar'], 
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
                
              },
            ),
          ),
          
        ],
      ),
    );
  }
}