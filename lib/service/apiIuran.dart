import 'dart:convert';
import 'package:http/http.dart' as http;

import '../errMsg.dart';
import '../keuangan/Iuran_Models.dart';

class ApiStatic {
  static const host = 'http://10.10.37.112:80';
  static const _token = "Bearer 2|9ZFbM6GoyKMU29P2W9uINrpwOm2zSrFwpSTriFVi";

  static String get jenisKegiatan => '';
  static Future<List<Iuran>> getIuran() async {
    try {
      final response = await http.get(Uri.parse("$host/api/iurans"), headers: {
        'Authorization': _token,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Iuran>((json) => Iuran.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // create & update
  static Future<ErrorMSG> saveIuran(
    String nama,
    String jenisKegiatan,
    int nominalUang,
    String buktiPembayaranPath,
    String filepath, // Tambahkan parameter ini
  ) async {
    try {
      var url = Uri.parse('$host/api/iurans');
      if (nama != 0) {
        url = Uri.parse('$host/api/iurans/' + nama.toString());
      }
      var request = http.MultipartRequest('IURAN', url);
      request.fields['nama'] = nama;
      request.fields['jenisKegiatan'] = jenisKegiatan;
      request.fields['nominalUang'] = nominalUang.toString();
      request.fields['buktiPembayaranPath'] = buktiPembayaranPath;
      if (filepath != '') {
        request.files.add(await http.MultipartFile.fromPath('image', filepath));
      }
      request.headers.addAll({
        'Authorization': _token,
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        return ErrorMSG(success: false, message: 'err Request');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'error caught: $e');
      return responseRequest;
    }
  }
}
