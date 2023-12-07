import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Kalender/Kalender_Models.dart';
import '../errMsg.dart';

class ApiStatic {
  static const host =
      'http://10.10.37.112:80'; // Ubah host sesuai dengan alamat server Anda
  static const _token = "Bearer 2|9ZFbM6GoyKMU29P2W9uINrpwOm2zSrFwpSTriFVi";

  static Future<List<Kalender>> getKalender() async {
    try {
      final response =
          await http.get(Uri.parse("$host/api/kalenders"), headers: {
        'Authorization': _token,
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Kalender> kalenderList =
            jsonData.map((json) => Kalender.fromJson(json)).toList();
        return kalenderList;
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

  static Future<ErrorMSG> saveKalender(
    String title,
    String note,
    DateTime date,
  ) async {
    try {
      var url =
          Uri.parse('$host/api/kalenders' + (title != '0' ? '/$title' : ''));
      var request = http.MultipartRequest('POST', url);

      // Mengirim data ke server
      request.fields['title'] = title;
      request.fields['note'] = note;
      request.fields['date'] =
          date.toIso8601String(); // Ubah format tanggal ke ISO 8601

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

  static Future<ErrorMSG> deleteKalender(String title) async {
    try {
      final response = await http.delete(
        Uri.parse('$host/api/kalenders/$title'),
        headers: {
          'Authorization': _token,
        },
      );
      if (response.statusCode == 200) {
        return ErrorMSG.fromJson(jsonDecode(response.body));
      } else {
        return ErrorMSG(
            success: false, message: 'Error, periksa kembali inputan Anda');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'Error caught: $e');
      return responseRequest;
    }
  }
}
