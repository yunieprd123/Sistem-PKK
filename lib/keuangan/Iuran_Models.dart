import 'dart:convert';

List<Iuran> iuranFromJson(String str) =>
    List<Iuran>.from(json.decode(str).map((x) => Iuran.fromJson(x)));

String iuranToJson(List<Iuran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Iuran {
  final String nama;
  final String jenisKegiatan;
  final int nominalUang; // Menggunakan tipe data int
  final String? buktiPembayaranPath;

  Iuran({
    required this.nama,
    required this.jenisKegiatan,
    required this.nominalUang,
    this.buktiPembayaranPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'jenisKegiatan': jenisKegiatan,
      'nominalUang': nominalUang,
      'buktiPembayaranPath': buktiPembayaranPath,
    };
  }

  factory Iuran.fromMap(Map<String, dynamic> map) {
    return Iuran(
      nama: map['nama'],
      jenisKegiatan: map['jenisKegiatan'],
      nominalUang: map['nominalUang'],
      buktiPembayaranPath: map['buktiPembayaranPath'],
    );
  }

  factory Iuran.fromJson(Map<String, dynamic> json) {
    // Mengambil nilai nominalUang sebagai int dari JSON
    int nominalInt = json['nominalUang'];

    return Iuran(
      nama: json['nama'],
      jenisKegiatan: json['jenisKegiatan'],
      nominalUang: nominalInt, // Menggunakan nilai int
      buktiPembayaranPath: json['buktiPembayaranPath'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nama'] = this.nama;
    data['jenisKegiatan'] = this.jenisKegiatan;

    data['nominalUang'] = this.nominalUang; // Menggunakan nilai int
    data['buktiPembayaranPath'] = this.buktiPembayaranPath;
    return data;
  }
}

// Mendefinisikan variabel untuk menyimpan nilai rupiah dalam bentuk integer
int nominalUangRupiah = 10000; // Ini mewakili Rp 10.000,00 dalam bentuk integer

 