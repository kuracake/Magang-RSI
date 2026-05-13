import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';

class HalamanFormMahasiswa extends StatefulWidget {
  final Map? data;

  const HalamanFormMahasiswa({super.key, this.data});
  

  @override
  State<HalamanFormMahasiswa> createState() => _HalamanFormMahasiswaState();
}

class _HalamanFormMahasiswaState extends State<HalamanFormMahasiswa> {
  final namaController = TextEditingController();
  final tglController = TextEditingController();
  final alamatController = TextEditingController();

  String gender = "L";

  List kotaList = [];
  List prodiList = [];

  String? selectedKota;
  String? selectedProdi;


  bool isLoading = false;

  @override
    void initState() {
      super.initState();
      loadDropdown();

      if (widget.data != null) {
        final item = widget.data!;

        namaController.text = item['nama_lengkap'] ?? '';
        tglController.text = item['tgl_lahir'] ?? '';
        alamatController.text = item['alamat'] ?? '';
        gender = item['gender'] ?? 'L';

        selectedKota = item['id_kota']?.toString();
        selectedProdi = item['id_prodi']?.toString();
      }
    }

  Future<void> loadDropdown() async {
    final kota = await ApiYusuf.getKota();
    final prodi = await ApiYusuf.getProdi();

    setState(() {
      kotaList = kota;
      prodiList = prodi;
    });
  }

  Future<void> submit() async {
    if (selectedKota == null || selectedProdi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih kota & prodi dulu")),
      );
      return;
    }

    setState(() => isLoading = true);

    bool success;

    if (widget.data == null) {
      // TAMBAH
      success = await ApiYusuf.tambahMahasiswa(
        namaLengkap: namaController.text,
        tglLahir: tglController.text,
        alamat: alamatController.text,
        gender: gender,
        idKota: selectedKota!,
        idProdi: selectedProdi!,
      );
    } else {
      // EDIT
      success = await ApiYusuf.updateDataMahasiswa(
        id: int.parse(widget.data!['id'].toString()),
        namaLengkap: namaController.text,
        tglLahir: tglController.text,
        alamat: alamatController.text,
        gender: gender,
        idKota: selectedKota!,
        idProdi: selectedProdi!,
      );
    }

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.data == null
                ? "Berhasil tambah mahasiswa"
                : "Berhasil update mahasiswa",
          ),
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menyimpan data")),
      );
    }
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      tglController.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data == null ? "Tambah Mahasiswa" : "Edit Mahasiswa",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: tglController,
              readOnly: true,
              onTap: pickDate,
              decoration: const InputDecoration(
                labelText: "Tanggal Lahir",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: "Alamat",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField(
              value: gender,
              items: const [
                DropdownMenuItem(value: "L", child: Text("Laki-laki")),
                DropdownMenuItem(value: "P", child: Text("Perempuan")),
              ],
              onChanged: (value) {
                setState(() => gender = value.toString());
              },
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              hint: const Text("Pilih Kota"),
              value: selectedKota,
              items: kotaList.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['id']?.toString() ?? '',
                  child: Text(item['nama'] ?? '-'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedKota = value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              hint: const Text("Pilih Prodi"),
              value: selectedProdi,
              items: prodiList.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['id']?.toString() ?? '',
                  child: Text(item['nama'] ?? '-'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedProdi = value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: submit,
                      child: const Text("Simpan"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}