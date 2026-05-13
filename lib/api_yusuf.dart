import 'package:dio/dio.dart';
import 'dart:convert';

class ApiYusuf {
  static const String baseUrl = 'https://online.rsisurabaya.com:1252/api/';
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ),
  );

  static Future<Response?> simpanData({
    required String nama,
    required String deskripsi,
    required String tglIns,
  }) async {
    try {
      final response = await dio.post(
        'insertPekerjaanMagang',
        data: {
          "nama": nama,
          "deskripsi": deskripsi,
          "tgl_ins": tglIns,
        },
      );
      return response;
    } on DioException catch (e) {
      print("Error: ${e.response?.data ?? e.message}");
      return null;
    }
  } //function create

  static Future<bool> deleteData(int id) async {
    try {
      final response = await dio.post(
        'deletePekerjaanMagang',
        data: {
          "id": id,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error delete: $e");
      return false;
    }
  } //function delete pekerjaan

  static Future<bool> updateData({
    required int id,
    required String nama,
    required String deskripsi,
    required String tglIns,
  }) async {
    try {
      final response = await dio.post(
        'updatePekerjaanMagang',
        data: {
          "id": id,
          "nama": nama,
          "deskripsi": deskripsi,
          "tgl_ins": tglIns,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error update: $e");
      return false;
    }
  } // function update

  static Future<List<dynamic>> getMahasiswa() async {
    try {
      final response = await dio.get('getMahasiswaMagang');
      print("RESPONSE: ${response.data}");
      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        return [];
      }
    } on DioException catch (e) {
      print("Error getMahasiswa: ${e.response?.data ?? e.message}");
      return [];
    }
  } //function get mahasiswa

  static Future<List<dynamic>> getKota() async {
    try {
      final response = await dio.get('getKotaMagang');
      if (response.statusCode == 200) {
        return response.data['results'] ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Error getKota: $e");
      return [];
    }
  } //function get kota

  static Future<List<dynamic>> getProdi() async {
    try {
      final response = await dio.get('getProdiMagang');
      if (response.statusCode == 200) {
        return response.data['results'] ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Error getProdi: $e");
      return [];
    }
  } //function get prodi

  static Future<bool> tambahMahasiswa({
    required String namaLengkap,
    required String tglLahir,
    required String alamat,
    required String gender,
    required String idKota,
    required String idProdi,
  }) async {
    try {
      final response = await dio.post(
        'insertMahasiswaMagang',
        data: {
          "nama_lengkap": namaLengkap,
          "tgl_lahir": tglLahir,
          "alamat": alamat,
          "gender": gender,
          "id_kota": idKota,
          "id_prodi": idProdi,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error tambahMahasiswa: $e");
      return false;
    }
  } //function tambah mahasiswa

  static Future<bool> deleteDataMahasiswa(int id) async {
    try {
      final response = await dio.post(
        'deleteMahasiswaMagang',
        data: {
          "id": id,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error delete: $e");
      return false;
    }
  } //function delete mahasiswa

  static Future<bool> updateDataMahasiswa({
    required int id,
    required String namaLengkap,
    required String tglLahir,
    required String alamat,
    required String gender,
    required String idKota,
    required String idProdi,
  }) async {
    try {
      final response = await dio.post(
        'updateMahasiswaMagang',
        data: {
          "id": id,
          "nama_lengkap": namaLengkap,
          "tgl_lahir": tglLahir,
          "alamat": alamat,
          "gender": gender,
          "id_kota": idKota,
          "id_prodi": idProdi,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error updateMahasiswa: $e");
      return false;
    }
  }

  // static Future<List<dynamic>> getPasien() async {
  //   try {
  //     final response = await dio.get('getRmMagang');

  //     print("DATA PASIEN: ${response.data}");
  //     print("TYPE: ${response.data.runtimeType}");

  //     if (response.statusCode == 200) {
  //       final data = response.data;

  //       // Jika response langsung berupa List
  //       if (data is List) return data;
  //     }

  //     return [];
  //   } on DioException catch (e) {
  //     print("ERROR GET PASIEN: ${e.response?.data ?? e.message}");
  //     return [];
  //   }
  // } //memanggil pasien

//   static Future<List<dynamic>> getPasien() async {
//   try {
//     final response = await dio.get('getRmMagang');

//     print("===============");
//     print("DATA PASIEN:");
//     print(response.data);
//     print("TYPE:");
//     print(response.data.runtimeType);
//     print("===============");

//     dynamic data = response.data;

//     // FIX: decode jika String
//     if (data is String) {
//       data = jsonDecode(data);
//     }

//     // Jika langsung List
//     if (data is List) {
//       return data;
//     }

//     // Jika Map dan ada data list
//     if (data is Map<String, dynamic>) {

//       // kemungkinan API:
//       // { success:true, data:[...] }

//       if (data['data'] is List) {
//         return data['data'];
//       }

//       // kemungkinan API:
//       // { results:[...] }

//       if (data['results'] is List) {
//         return data['results'];
//       }

//       // kemungkinan API hanya 1 pasien object
//       if (data['nama'] != null) {
//         return [data];
//       }
//     }

//     return [];

//   } on DioException catch (e) {

//     print("ERROR GET PASIEN:");
//     print(e.response?.data ?? e.message);

//     return [];

//   } catch (e) {

//     print("ERROR:");
//     print(e);

//     return [];
//   }
// }

  static Future<Map<String, dynamic>?> loginPasien({
    required String noRm,
    required String tanggalLahir,
  }) async {
    try {
      final response = await dio.post(
        'loginRmMagang',
        data: {
          "norm": noRm,
          "birthdate": tanggalLahir,
        },
      );

      print("===============");
      print("LOGIN RESPONSE:");
      print(response.data);
      print("TYPE:");
      print(response.data.runtimeType);
      print("===============");

      dynamic data = response.data;

      // FIX UTAMA: decode jika masih String
      if (data is String) {
        data = jsonDecode(data);
      }

      // Sekarang data sudah Map
      if (data is Map<String, dynamic>) {

        // cek success
        if (data['success'] == true) {

          // ambil data pasien
          if (data['data'] != null) {
            return Map<String, dynamic>.from(data['data']);
          }
        }
      }

      return null;

    } on DioException catch (e) {

      print("LOGIN ERROR:");
      print(e.response?.data);
      print(e.message);

      return null;
    } catch (e) {

      print("ERROR:");
      print(e);

      return null;
    }
  } // login pasien

    static Future<List<dynamic>> getTitle() async {
      try {
        final response = await dio.get('getRankMlbbMagang');
        if (response.statusCode == 200) {
          return response.data['results'] ?? [];
        } else {
          return [];
        }
      } catch (e) {
        print("Error getRankMlbb: $e");
        return [];
      }
    } //get rank mlbb

  static Future<bool> insertQr({
    required String username,
    required String title,
  }) async {

    try {

      final response = await dio.post(

        'insertQrMagang',

        data: {

          "username": username,
          "title": title,
          

        },
      );

      print("INSERT RESPONSE:");
      print(response.data);

      if (response.statusCode == 200) {

        return true;

      } else {

        return false;
      }

    } catch (e) {

      print("ERROR INSERT QR:");
      print(e);

      return false;
    }
  } //post data
}