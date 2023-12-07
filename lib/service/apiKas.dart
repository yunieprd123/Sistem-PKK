import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Kas/kasUmum_Models.dart';
import '../errMsg.dart';

class ApiStatic {
  static const host =
      'http://10.10.37.112:80'; // Ubah host sesuai dengan alamat server Anda
  static const _token = "Bearer 2|9ZFbM6GoyKMU29P2W9uINrpwOm2zSrFwpSTriFVi";

  static Future<List<KasUmum>> getKasUmum() async {
    try {
      final response =
          await http.get(Uri.parse("$host/api/kasumums"), headers: {
        'Authorization': _token,
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<KasUmum> kasumumList =
            jsonData.map((json) => KasUmum.fromJson(json)).toList();
        return kasumumList;
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

  static Future<ErrorMSG> saveKasUmum(
    int id,
    String keterangan,
    int jumlah,
    DateTime tanggal,
    bool isPemasukan,
  ) async {
    try {
      var url = Uri.parse('$host/api/kasumums' + (id != 0 ? '/$id' : ''));
      var request = http.MultipartRequest('POST', url);

      // Mengirim data ke server
      request.fields['id'] = id.toString();
      request.fields['keterangan'] = keterangan;
      request.fields['jumlah'] = jumlah.toString();
      request.fields['tanggal'] = tanggal.toIso8601String();
      request.fields['isPemasukan'] = isPemasukan.toString();

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

  static Future<ErrorMSG> deleteKasUmum(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$host/api/kasumums/$id'),
        headers: {
          'Authorization': _token,
        },
      );
      if (response.statusCode == 200) {
        return ErrorMSG.fromJson(jsonDecode(response.body));
      } else {
        return ErrorMSG(
            success: false, message: 'Err, periksa kembali inputan Anda');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'error caught: $e');
      return responseRequest;
    }
  }
}
