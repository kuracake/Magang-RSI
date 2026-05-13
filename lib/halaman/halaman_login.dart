import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';
import 'package:magang_yusuf/halaman/halaman_pasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final TextEditingController noRmController = TextEditingController();
  final TextEditingController tglLahirController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  // =========================
  // CEK LOGIN
  // =========================
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool("isLogin") ?? false;

    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HalamanPasien(),
        ),
      );
    }
  }

  // =========================
  // LOGIN
  // =========================
  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    String noRm = noRmController.text.trim();
    String tglLahir = tglLahirController.text.trim();

    // VALIDASI KOSONG
    if (noRm.isEmpty || tglLahir.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nomor RM dan Tanggal Lahir wajib diisi"),
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    // HIT API LOGIN
    final pasien = await ApiYusuf.loginPasien(
      noRm: noRm,
      tanggalLahir: tglLahir,
    );

    // JIKA ADA DATA
    if (pasien != null) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool("isLogin", true);

      // FIX: Simpan semua field penting dengan null-safety
      await prefs.setString("no_rm", pasien['no_rm']?.toString() ?? "");
      await prefs.setString("nama", pasien['nama']?.toString() ?? "");
      await prefs.setString(
          "tanggal_lahir", pasien['tanggal_lahir']?.toString() ?? "");
      await prefs.setString(
          "jenis_kelamin", pasien['jenis_kelamin']?.toString() ?? "");
      await prefs.setString("alamat", pasien['alamat']?.toString() ?? "");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HalamanPasien(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nomor RM atau Tanggal Lahir salah"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  // =========================
  // DATE PICKER
  // =========================
  Future<void> pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String tanggal =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      tglLahirController.text = tanggal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F8F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // ================= HEADER =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 24,
                  right: 24,
                  bottom: 50,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1FA971),
                      Color(0xff138A5C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [

                    // LOGO RSI
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset("asset/images/logo_rsi.webp"),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Login Pasien MCU",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Silahkan login menggunakan\nNomor Rekam Medis dan Tanggal Lahir",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // ================= CARD =================
              Transform.translate(
                offset: const Offset(0, -25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        // NOMOR RM
                        TextField(
                          controller: noRmController,
                          decoration: InputDecoration(
                            labelText: "Nomor Rekam Medis",
                            prefixIcon: const Icon(
                              Icons.badge_outlined,
                              color: Color(0xff1FA971),
                            ),
                            filled: true,
                            fillColor: const Color(0xffF4F8F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // TANGGAL LAHIR
                        TextField(
                          controller: tglLahirController,
                          readOnly: true,
                          onTap: pilihTanggal,
                          decoration: InputDecoration(
                            labelText: "Tanggal Lahir",
                            prefixIcon: const Icon(
                              Icons.calendar_month_outlined,
                              color: Color(0xff1FA971),
                            ),
                            filled: true,
                            fillColor: const Color(0xffF4F8F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // BUTTON LOGIN
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff1FA971),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}