import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';
import 'package:magang_yusuf/halaman/detail_pekerjaan.dart';
import 'package:magang_yusuf/styling/form_dialog.dart';
import 'package:magang_yusuf/styling/inputku.dart';
import 'package:magang_yusuf/styling/swipe_delete.dart';

class HalamanPekerjaan extends StatefulWidget {
  const HalamanPekerjaan({super.key});

  @override
  State<HalamanPekerjaan> createState() => _HalamanPekerjaanState();
}

class _HalamanPekerjaanState extends State<HalamanPekerjaan> {
  bool isLoading = true;
  List<Map<String,dynamic>> listPekerjaan = [];
  // WAJIB FILTER
  List<Map<String,dynamic>> filteredPekerjaan = [];
  String pesan = "";
  bool adaData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPekerjaan();
  }

  Future<void> getPekerjaan() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try{
      // WAJIB (1)
      final response = await ApiYusuf.dio.get('getPekerjaanMagang');
      var data = response.data;
      if (data is String){
        data = jsonDecode(data);
      } 
      // END WAJIB (1)

      //1. UNTUK NGECEK ADA DATA
      if(data != null && data['success'] == true){
        // WAJIB (2) HARUS PAKAI MOUNTED, BIAR SAAT HALAMAN DIBUKA NGELOAD SAMPAI SELESAI DULU
        if(mounted){
          setState(() {
            // WAJIB (3) POPULASI LISTNYA, WAJIB SEPERTI INI: List<Map<String, dynamic>>.from(data['results']);
            listPekerjaan = List<Map<String, dynamic>>.from(data['results']);
            // WAJIB FILTER
            filteredPekerjaan = listPekerjaan;
            isLoading = false;
            adaData = true;
          });
        }
      } 
      //2. UNTUK NGECEK JIKA DATA TIDAK ADA
      else {
        if(mounted){
          setState(() {
            isLoading = false;
            pesan = "Data yang kalian cari tidak ada";
            adaData = false;
          });
        }
      }
    } catch (e){
      if (mounted) {
        setState(() {
          isLoading = false;
          pesan = 'Terjadi kesalahan koneksi server.';
          adaData = false;
        });
      }
    }
  }

  // WAJIB FILTER
  void searchPekerjaan(String keyword) {
    final key = keyword.toLowerCase();

    final hasil = listPekerjaan.where((item) {
      final deskripsi = item['deskripsi'].toString().toLowerCase();
      final nama = item['nama'].toString().toLowerCase();

      return deskripsi.contains(key) || nama.contains(key);
    }).toList();

    setState(() {
      filteredPekerjaan = hasil;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AMBIL DATA REAL"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => TambahDataDialog(
                onSuccess: () async {
                await getPekerjaan();
                }
              ),
            );
          },
        ),
        ]
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: isLoading ? CircularProgressIndicator() : 
          adaData ?
          Column(
            children: [
              InputKu( 
                hint: "cari woi",
                onChanged: (value) {
                  searchPekerjaan(value);
                },
              ),

              SizedBox(height: 10,),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: getPekerjaan,
                  child: ListView.builder(
                    itemCount: filteredPekerjaan.length,
                    itemBuilder: (context, index) {
                      final item = filteredPekerjaan[index];
                      return SwipeDeleteItem(
                        item: item,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPekerjaan(item: item),
                            ),
                          );

                          if (result != null) {
                            await getPekerjaan(); // refresh otomatis setelah edit
                          }
                        },
                        onRefresh: getPekerjaan, // penting
                      );
                }
            )
            )
            )
            ]
          ) : Text(pesan),
        ),
      ),
    );
  }
}

