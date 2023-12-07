import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Iuran_Models.dart';
import 'iuran.dart';

class InputIuranPage extends StatefulWidget {
  @override
  _InputIuranPageState createState() => _InputIuranPageState();
}

class _InputIuranPageState extends State<InputIuranPage> {
  double totalKeuangan = 0.0;
  final TextEditingController namaController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String? selectedKegiatan;
  double nominalUang = 0.0;
  File? buktiPembayaran;
  final picker = ImagePicker();

  final List<String> jenisKegiatanOptions = [
    'Bersih-bersih',
    '17 Agustus',
    'Makan-makan',
    'Arisan',
    'P2k (Iuran beras/gelas)',
  ];

  String formatRupiah(double nominal) {
    String rupiah = nominal.toStringAsFixed(2); // Menambahkan 2 digit desimal
    List<String> splitRupiah = rupiah.split('.');
    String result = '';
    int count = 0;

    for (int i = splitRupiah[0].length - 1; i >= 0; i--) {
      result = splitRupiah[0][i] + result;
      count++;
      if (count == 3 && i > 0) {
        result = '.' + result;
        count = 0;
      }
    }
    return 'Rp $result,${splitRupiah[1]}';
  }

  String? selectedNamaAnggota;

  List<String> namaAnggotaOptions = [
    'KETUA: Nyonya Anggraini Pariadnyana',
    'WAKIL KETUA: Kadek Ariantini',
    'SEKRETARIS: Luh Erawati',
    'WAKIL SEKRETARIS: Made Laksemi Wati',
    'BENDAHARA: Komang Sri Yuliani',
    'WAKIL BENDAHARA: Made Sari',
    'MEMBIDANGI PENGHAYATAN DAN PENGAMALAN PANCASILA DAN GOTONG ROYONG',
    'POKJA I',
    'KETUA: Carmelinda Carvalho',
    'WAKIL: Luh Putu Warini',
    'SEKRETARIS: Made Susari Dewi',
    'Ni Luh Karoni',
    'Luh Sri Nadi',
    'Putu Budari',
    'Made Suastini',
    'Kadek Sintawati',
    'Luh Sukerini',
    'Luh Darmiyanti',
    'Nyoman Wiliani',
    'Luh Sukarmiadi',
    'Kadek Aryantini',
    'Komang Darini',
    'MEMBIDANGI PENDIDIKAN, KETERAMPILAN DAN PENGEMBANGAN KEHIDUPAN BERKOPRASI',
    'POKJA II ',
    'KETUA: I Ketut Megawati',
    'WAKIL: Kadek Suparti',
    'SEKRETARIS: Ni Made Jero',
    'Putu Eni Arwati',
    'Ni Made Wartini',
    'Ni Komang Sukerti',
    'Desak Sulastri',
    'Putu Kawi',
    'Ketut Esti Setia Purnama Dewi',
    'Made Dwittari Pande',
    'Ni Komang Budikertiasih',
    'Ni Luh Putu Erna Purnama Wardani',
    'Luh Mini',
    'MEMBIDANGI PANGAN, SANDANG, PERUMAHAN  DAN TATA LAKSANA RUMAH TANGGA',
    'POKJA III',
    'KETUA: Ni Luh Duriani Pande',
    'WAKIL: Luh Swinadi',
    'SEKRETARIS: Komang Desy Ariani',
    'Made Budiayu',
    'Kadek Purnami',
    'Ni Kadek Elfira Meirosa Perasi',
    'Ketut Kartika',
    'Ketut Evin Handayanti',
    'Komang Ariani',
    'Ketut Suandayani',
    'Jro Nyoman Sudarbi',
    'Kadek Dewi Indrayani',
    'Ketut Setia Wati',
    'Gusti Ayu Dewi Pujayani',
    'Komang Siti Suryani',
    'MEMBIDANGI KESEHATAN, KELESTARIAN  LINGKUNGAN HIDUP DAN PERENCANAAN KESEHATAN',
    'POKJA IV',
    'KETUA: Luh Alit Mahendra Wati',
    'WAKIL: Kadek Suartini',
    'SEKRETARIS: Komang Intan Suryani',
    'Kadek Desy Arisandi',
    'Luh Anita',
    'Luh Budartini',
    'Komang Suardeni',
    'Komang Asrini',
    'Gusti Ayu Ketut Armeni',
    'Nyoman Sariani',
    'Wayan Karini',
    'Ni Kadek Rasmini',
    'Komang Ardiani',
    'Luh Juliantini',
    'Kadek Desi',
    'Luh Setiani',
    'Ketut Suanda Yani',
    'Kadek Suarmini',
  ];

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        buktiPembayaran = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Iuran'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Nama Anggota',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  labelText: "Cari Nama Anggota",
                  prefixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(
                    color: Colors.pink,
                  )),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: namaAnggotaOptions.length,
                itemBuilder: (context, index) {
                  bool isgrey = namaAnggotaOptions[index].contains(
                          "MEMBIDANGI PENGHAYATAN DAN PENGAMALAN PANCASILA DAN GOTONG ROYONG") ||
                      namaAnggotaOptions[index].contains("POKJA I");
                  if (searchController.text.isNotEmpty &&
                      !namaAnggotaOptions[index]
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                    return SizedBox.shrink();
                  }
                  return Card(
                    margin: EdgeInsets.all(4),
                    child: ListTile(
                      title: Text(
                        namaAnggotaOptions[index],
                        style: TextStyle(
                          color: isgrey ? Colors.grey : Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedNamaAnggota = namaAnggotaOptions[index];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedKegiatan,
              onChanged: (value) {
                setState(() {
                  selectedKegiatan = value;
                });
              },
              items: jenisKegiatanOptions.map((kegiatan) {
                return DropdownMenuItem<String>(
                  value: kegiatan,
                  child: Text(kegiatan),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Jenis Kegiatan'),
            ),
            SizedBox(
              height: 16,
            ),
            // Text('Nominal Uang: ${formatRupiah(nominalUang.round())}'),
            TextField(
              controller: TextEditingController(
                  text: formatRupiah(nominalUang.round() as double)),
              decoration: InputDecoration(
                labelText: "Nominal Uang",
                prefixIcon:
                    Icon(Icons.monetization_on), // Ikoni dengan icon uang
              ),
              onChanged: (value) {
                final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
                setState(() {
                  nominalUang = double.parse(cleanValue);
                });
              },
              keyboardType: TextInputType.number, // Tampilkan keyboard numerik
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Unggah Gambar/Bukti Pembayaran'),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final String namaAnggota = selectedNamaAnggota ?? '';
                    final String jenisKegiatan = selectedKegiatan ?? '';
                    final int nominalUangInt = nominalUang.round();
                    final String? buktiPembayaranPath = buktiPembayaran?.path;

                    totalKeuangan += nominalUangInt.toDouble();

                    final iuran = Iuran(
                      nama: namaAnggota,
                      jenisKegiatan: jenisKegiatan,
                      nominalUang: nominalUangInt,
                      buktiPembayaranPath: buktiPembayaranPath,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IuranPage(
                          iuran: iuran,
                          buktiPembayaran: buktiPembayaranPath,
                          totalKeuangan: totalKeuangan,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.save),
                  label: Text('Simpan Data Keuangan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
