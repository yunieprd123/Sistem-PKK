import 'dart:convert';
import 'dart:io';

List<Anggota> anggotaFromJson(String str) =>
    List<Anggota>.from(json.decode(str).map((x) => Anggota.fromJson(x)));

String anggotaToJson(List<Anggota> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Anggota {
  final String nama;
  final String jabatan;
  final String pokja;
  final File? image;
  final bool status;

  Anggota({
    required this.nama,
    required this.jabatan,
    required this.pokja,
    this.image,
    this.status = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'jabatan': jabatan,
      'pokja': pokja,
      'image': image?.path, // Mengambil path gambar jika ada
      'status': status,
    };
  }

  factory Anggota.fromMap(Map<String, dynamic> map) {
    return Anggota(
      nama: map['nama'],
      jabatan: map['jabatan'],
      pokja: map['pokja'],
      image: map['image'] != null ? File(map['image']) : null,
      status: map['status'],
    );
  }

  factory Anggota.fromJson(Map<String, dynamic> json) => Anggota(
        nama: json["nama"],
        jabatan: json["jabatan"],
        pokja: json["pokja"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "jabatan": jabatan,
        "pokja": pokja,
        "image": image,
        "status": status,
      };
}

// Variabel anggotaList dideklarasikan di luar kelas Anggota
final List<Anggota> anggotaList = [
  Anggota(
    nama: 'KETUA: Nyonya Anggraini Pariadnyana',
    jabatan: 'KETUA',
    pokja: 'Pokja 1',
  ),
  Anggota(
    nama: 'WAKIL KETUA: Kadek Ariantini',
    jabatan: 'WAKIL KETUA',
    pokja: 'Pokja 2',
  ),
  // Tambahkan anggota dan jabatan lainnya sesuai dengan struktur di atas
];
