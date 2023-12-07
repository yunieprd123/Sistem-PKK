import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errMsg.dart';
import '../pages/Absensi_Models.dart';

class ApiAbsensi {
  static const host = 'http://10.10.37.112:80';
  static const _token = "Bearer 2|9ZFbM6GoyKMU29P2W9uINrpwOm2zSrFwpSTriFVi";
  static Future<List<Absensi>> getAbsensi() async {
    try {
      final response = await http.get(Uri.parse("$host/api/absens"), headers: {
        'Authorization': _token,
      });
      print('absen');
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Absensi>((json) => Absensi.fromJson(json)).toList();
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
  static Future<ErrorMSG> saveAbsensi(
      String nama,
      String jabatan,
      String hadir,
      String tidakHadir,
      String alasanTidakHadir,
      String tanggal,
      String kegiatan) async {
    try {
      var url = Uri.parse('$host/api/absens');
      if (nama != '0') {
        // Ganti 0 dengan tipe data yang sesuai (misalnya '0' jika nama adalah string)
        url = Uri.parse('$host/api/absens/' + nama.toString());
      }

      var request = http.MultipartRequest(
          'POST', url); // Ganti 'POST' sesuai dengan metode yang sesuai

      // Mengirim data ke server
      request.fields['nama'] = nama;
      request.fields['jabatan'] = jabatan;
      request.fields['hadir'] = hadir.toString();
      request.fields['tidakHadir'] = tidakHadir.toString();
      request.fields['alasanTidakHadir'] = alasanTidakHadir.toString();
      request.fields['tanggal'] = tanggal;
      request.fields['kegiatan'] = kegiatan;

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
  static Future<ErrorMSG> deleteAbsensi(nama) async {
    try {
      final response = await http
          .delete(Uri.parse('$host/api/absens/' + nama.toString()), headers: {
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
