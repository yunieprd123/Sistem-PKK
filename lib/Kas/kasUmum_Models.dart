import 'dart:convert';

List<KasUmum> kasumumFromJson(String str) =>
    List<KasUmum>.from(json.decode(str).map((x) => KasUmum.fromJson(x)));

String kasumumToJson(List<KasUmum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KasUmum {
  int id;
  String keterangan;
  int jumlah;
  DateTime tanggal;
  bool isPemasukan;

  KasUmum({
    required this.id,
    required this.keterangan,
    required this.jumlah,
    required this.tanggal,
    required this.isPemasukan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'keterangan': keterangan,
      'jumlah': jumlah,
      'tanggal': tanggal,
      'isPemasukan': isPemasukan,
    };
  }

  factory KasUmum.fromMap(Map<String, dynamic> map) {
    return KasUmum(
      id: map['id'],
      keterangan: map['keterangan'],
      jumlah: map['jumlah'],
      tanggal: DateTime.parse(map['tanggal']), // Ubah ke DateTime
      isPemasukan: map['isPemasukan'], // Tambahkan isPemasukan
    );
  }

  factory KasUmum.fromJson(Map<String, dynamic> json) => KasUmum(
        id: json["id"],
        keterangan: json["keterangan"],
        jumlah: json["jumlah"],
        tanggal: DateTime.parse(json["tanggal"]), // Ubah ke DateTime
        isPemasukan: json["isPemasukan"], // Tambahkan isPemasukan
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "keterangan": keterangan,
        "jumlah": jumlah,
        "tanggal": tanggal.toIso8601String(), // Ubah ke format ISO 8601
        "isPemasukan": isPemasukan,
      };
}
