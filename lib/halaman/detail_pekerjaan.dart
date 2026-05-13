import 'package:flutter/material.dart';
import 'package:magang_yusuf/styling/edit_dialog.dart';

class DetailPekerjaan extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailPekerjaan({super.key, required this.item});

  @override
  State<DetailPekerjaan> createState() => _DetailPekerjaanState();
}

class _DetailPekerjaanState extends State<DetailPekerjaan> {
  late Map<String, dynamic> item;

  @override
  void initState() {
    super.initState();
    item = widget.item; // ambil data awal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['nama'] ?? ''),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => EditDialog(
                  item: item,
                ),
              );

              if (result != null) {
                setState(() {
                  item = result; // update data langsung
                });
                Navigator.pop(context, result);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              item['file'] ?? '',
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 50);
              },
            ),
            SizedBox(height: 16),
            Text(
              item['nama'] ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Tanggal: ${item['tgl_ins'] ?? '-'}"),
            SizedBox(height: 8),
            Text("Deskripsi: ${item['deskripsi'] ?? '-'}"),
          ],
        ),
      ),
    );
  }
}