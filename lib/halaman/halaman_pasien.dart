import 'package:flutter/material.dart';
import 'package:magang_yusuf/halaman/halaman_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanPasien extends StatefulWidget {
  const HalamanPasien({super.key});

  @override
  State<HalamanPasien> createState() => _HalamanPasienState();
}

class _HalamanPasienState extends State<HalamanPasien> {
  Map<String, dynamic> pasien = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPasien();
  }

  Future<void> loadPasien() async {

  final prefs = await SharedPreferences.getInstance();

  setState(() {
    pasien = {
      "nama": prefs.getString("nama") ?? "-",
      "no_rm": prefs.getString("no_rm") ?? "-",
      "tanggal_lahir": prefs.getString("tanggal_lahir") ?? "-",
      "jenis_kelamin": prefs.getString("jenis_kelamin") ?? "-",
      "alamat": prefs.getString("alamat") ?? "-",
    };

    isLoading = false;
  });
}

  // ======================
  // LOGOUT
  // ======================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HalamanLogin(),
      ),
    );
  }

  // ======================
  // UI
  // ======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F8F6),

      appBar: AppBar(
        backgroundColor: const Color(0xff1FA971),
        foregroundColor: Colors.white,
        title: const Text("Data Pasien"),
        centerTitle: true,

        // FIX: Tambahkan tombol logout
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: logout,
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pasien.isEmpty
              ? const Center(child: Text("Data pasien kosong"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE8FFF4),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xff1FA971),
                                  size: 32,
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pasien['nama'] ?? "-",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      "No RM : ${pasien['no_rm']}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          buildItem(
                            Icons.calendar_month,
                            "Tanggal Lahir",
                            pasien['tanggal_lahir'] ?? "-",
                          ),

                          const SizedBox(height: 14),

                          buildItem(
                            Icons.wc,
                            "Jenis Kelamin",
                            pasien['jenis_kelamin'] ?? "-",
                          ),

                          const SizedBox(height: 14),

                          buildItem(
                            Icons.location_on,
                            "Alamat",
                            pasien['alamat'] ?? "-",
                          ),
                        ],
                      ),
                    ),
                  ),
                )
    );
  }

  // ======================
  // ITEM DETAIL
  // ======================
  Widget buildItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xff1FA971),
          size: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}