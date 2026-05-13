import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';
import 'package:magang_yusuf/halaman/halaman_form_mahasiswa.dart';
import 'package:magang_yusuf/halaman/halaman_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanMahasiswa extends StatefulWidget {
  const HalamanMahasiswa({super.key});

  @override
  State<HalamanMahasiswa> createState() => _HalamanMahasiswaState();
}

class _HalamanMahasiswaState extends State<HalamanMahasiswa> {
  List mahasiswa = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await ApiYusuf.getMahasiswa();

      setState(() {
        mahasiswa = data;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR FETCH: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Mahasiswa"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {

              // HAPUS SESSION LOGIN
              final prefs = await SharedPreferences.getInstance();

              await prefs.clear();

              // PINDAH KE LOGIN
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HalamanLogin(),
                ),
              );
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : mahasiswa.isEmpty
              ? const Center(child: Text("Data kosong"))
              : ListView.builder(
                  itemCount: mahasiswa.length,
                  itemBuilder: (context, index) {
                    final item = mahasiswa[index];

                    return Dismissible(
                      key: Key(item['id'].toString()),

                      direction: DismissDirection.endToStart, // swipe kanan → kiri

                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),

                      confirmDismiss: (direction) async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Konfirmasi"),
                            content: const Text("Yakin ingin menghapus data ini?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Batal"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Hapus"),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          final id = int.parse(item['id'].toString());

                          final success = await ApiYusuf.deleteDataMahasiswa(id);

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Data berhasil dihapus")),
                            );
                            return true; // baru dihapus dari UI
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Gagal menghapus data")),
                            );
                            return false; // batal hapus UI
                          }
                        }

                        return false;
                      },

                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HalamanFormMahasiswa(data: item),
                              ),
                            );

                            if (result == true) {
                              fetchData();
                            }
                          },
                          leading: CircleAvatar(
                            child: Text(item['nama_lengkap'][0]),
                          ),
                          title: Text(
                            item['nama_lengkap'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${item['nama_kota']} • ${item['nama_prodi']}",
                          ),
                        ),
                      ),
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HalamanFormMahasiswa(),
                      ),
                    );

                    if (result == true) {
                      fetchData(); // refresh otomatis
                    }
                  },
                  child: const Icon(Icons.add),
                ),
    );
  }
}