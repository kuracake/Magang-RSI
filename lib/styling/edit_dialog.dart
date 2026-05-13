import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';

class EditDialog extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditDialog({
    super.key,
    required this.item,
  });

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController nama;
  late TextEditingController deskripsi;
  late TextEditingController tanggal;

  @override
  void initState() {
    super.initState();

    //  isi default dari data lama
    nama = TextEditingController(text: widget.item['nama']);
    deskripsi = TextEditingController(text: widget.item['deskripsi']);
    tanggal = TextEditingController(text: widget.item['tgl_ins']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Data"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nama,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: deskripsi,
              decoration: InputDecoration(labelText: "Deskripsi"),
            ),
            TextField(
              controller: tanggal,
              decoration: InputDecoration(labelText: "Tanggal"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => 
          Navigator.pop(context, {
            'nama': nama.text,
            'deskripsi': deskripsi.text,
            'tgl_ins': tanggal.text,
            'file': widget.item['file'], // jangan hilangin ini
          }),
          child: Text("Batal"),
        ),
        ElevatedButton(
          child: Text('simpan'),
          onPressed: () async {
            final id = int.parse(widget.item['id'].toString());

            bool success = await ApiYusuf.updateData(
              id: id,
              nama: nama.text,
              deskripsi: deskripsi.text,
              tglIns: tanggal.text,
            );

            if (success) {
              //  tampilkan dulu feedback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Data berhasil diupdate")),
              );

              //  baru kirim data balik
              Navigator.pop(context, {
                'id': id,
                'nama': nama.text,
                'deskripsi': deskripsi.text,
                'tgl_ins': tanggal.text,
                'file': widget.item['file'],
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Gagal update")),
              );
            }
          }
        ),
      ],
    );
  }
}