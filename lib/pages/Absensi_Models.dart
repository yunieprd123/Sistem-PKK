import 'dart:convert';

List<Absensi> absensiFromJson(String str) =>
    List<Absensi>.from(json.decode(str).map((x) => Absensi.fromJson(x)));

String absensiToJson(List<Absensi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Absensi {
  final String nama;
  final String jabatan;
  final String hadir;
  final String tidakHadir;
  final String kegiatan;
  final DateTime tanggal;
  final String alasanTidakHadir;

  Absensi({
    required this.nama,
    required this.jabatan,
    required this.hadir,
    required this.tidakHadir,
    required this.kegiatan,
    required this.tanggal,
    required this.alasanTidakHadir,
  });

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      nama: json['nama'],
      jabatan: json['jabatan'],
      hadir: json['hadir'],
      tidakHadir: json['tidakHadir'],
      kegiatan: json['kegiatan'],
      tanggal: DateTime.parse(json['tanggal']),
      alasanTidakHadir: json['alasanTidakHadir'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'jabatan': jabatan,
      'hadir': hadir,
      'tidakHadir': tidakHadir,
      'kegiatan': kegiatan,
      'tanggal': tanggal.toIso8601String(),
      'alasanTidakHadir': alasanTidakHadir,
    };
  }
}
