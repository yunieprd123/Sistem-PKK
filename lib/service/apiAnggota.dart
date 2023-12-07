import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Anggota/Anggota_Models.dart';
import '../errMsg.dart';

class ApiStatic {
  static const host = 'http://10.10.37.112:80';
  static const _token = "Bearer 2|9ZFbM6GoyKMU29P2W9uINrpwOm2zSrFwpSTriFVi";
  static Future<List<Anggota>> getAnggota() async {
    try {
      final response =
          await http.get(Uri.parse("$host/api/anggotas"), headers: {
        'Authorization': _token,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Anggota>((json) => Anggota.fromJson(json)).toList();
      } else {
        print("Error: ${response.statusCode}");
        print(response.body);
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  // create & update
  static Future<ErrorMSG> saveAnggota(String nama, String jabatan, String pokja,
      http.MultipartFile image, bool status) async {
    try {
      var url = Uri.parse('$host/api/anggotas');
      if (nama != '0') {
        // Ganti 0 dengan tipe data yang sesuai (misalnya '0' jika nama adalah string)
        url = Uri.parse('$host/api/anggotas/' + nama.toString());
      }

      var request = http.MultipartRequest(
          'anggotas', url); // Ganti 'POST' sesuai dengan metode yang sesuai

      // Mengirim data ke server
      request.fields['nama'] = nama;
      request.fields['jabatan'] = jabatan;
      request.fields['pokja'] = pokja;
      request.fields['image'] = image as String;
      request.fields['status'] = status as String;

      request.headers.addAll({
        'Authorization': _token,
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        return ErrorMSG(
            success: false,
            message: 'Gagal melakukan permintaan: ${response.reasonPhrase}');
      }
    } catch (e) {
      return ErrorMSG(success: false, message: 'Terjadi kesalahan: $e');
    }
  }

  // delete
  static Future<ErrorMSG> deleteAnggota(judul) async {
    try {
      final response = await http.delete(
          Uri.parse('$host/api/anggotas/' + judul.toString()),
          headers: {
            'Authorization': _token,
          });
      if (response.statusCode == 200) {
        return ErrorMSG.fromJson(jsonDecode(response.body));
      } else {
        return ErrorMSG(
            success: false, message: 'Err, periksan kembali inputan anda');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'error caught: $e');
      return responseRequest;
    }
  }
}
