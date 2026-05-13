import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';

class TambahDataDialog extends StatefulWidget {
   final Function onSuccess;

  const TambahDataDialog({super.key, required this.onSuccess});
  @override
  _TambahDataDialogState createState() => _TambahDataDialogState();
}

class _TambahDataDialogState extends State<TambahDataDialog> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController tanggal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Tambah Data"),
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
              readOnly: true,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  tanggal.text = "${picked.toString().split(' ')[0]} 00:00:00";
                }
              },
              decoration: InputDecoration(labelText: "Tanggal"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Batal"),
        ),
        ElevatedButton(
          child: Text('simpan'),
          onPressed: () async {
            final response = await ApiYusuf.simpanData(
              nama: nama.text,
              deskripsi: deskripsi.text,
              tglIns: tanggal.text,
            );

            if (response != null) {
              print("Berhasil simpan");
              widget.onSuccess();
              Navigator.pop(context);
            } else {
              print("Gagal simpan");
            }
          },
        ),
      ],
    );
  }
}