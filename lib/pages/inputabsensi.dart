import 'package:flutter/material.dart';
import 'Absensi_Models.dart';

class InputAbsensiPage extends StatefulWidget {
  DateTime selectedDate;
  final String kegiatan;
  String? jenisKegiatan;
  final TextEditingController tanggalController;

  String? selectedNamaAnggota;
  List<String> namaAnggotaOptions = [
    'Nyonya Anggraini Pariadnyana',
    'Kadek Ariantini',
    'Luh Erawati',
    'Made Laksemi Wati',
    'Komang Sri Yuliani',
    'Made Sari',
    'MEMBIDANGI PENGHAYATAN DAN PENGAMALAN PANCASILA DAN GOTONG ROYONG',
    'POKJA I',
    'Carmelinda Carvalho',
    'Luh Putu Warini',
    'Made Susari Dewi',
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
    'I Ketut Megawati',
    'Kadek Suparti',
    'Ni Made Jero',
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
    'Ni Luh Duriani Pande',
    'Luh Swinadi',
    'Komang Desy Ariani',
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
    'Luh Alit Mahendra Wati',
    'Kadek Suartini',
    'Komang Intan Suryani',
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

  final Map<String, String> jabatanMap = {
    'Nyonya Anggraini Pariadnyana': 'Ketua',
    'Kadek Ariantini': 'Wakil Ketua',
    'Luh Erawati': 'Bendahara',
    'Made Laksemi Wati': 'Sekretaris',
    'Komang Sri Yuliani': 'Anggota',
    'Made Sari': 'Anggota',
    'Carmelinda Carvalho': 'Anggota',
    'Luh Putu Warini': 'Anggota',
    'Made Susari Dewi': 'Anggota',
    'Ni Luh Karoni': 'Anggota',
    'Luh Sri Nadi': 'Anggota',
    'Putu Budari': 'Anggota',
    'Made Suastini': 'Anggota',
    'Kadek Sintawati': 'Anggota',
    'Luh Sukerini': 'Anggota',
    'Luh Darmiyanti': 'Anggota',
    'Nyoman Wiliani': 'Anggota',
    'Luh Sukarmiadi': 'Anggota',
    'Kadek Aryantini': 'Anggota',
    'Komang Darini': 'Anggota',
    'I Ketut Megawati': 'Anggota',
    'Kadek Suparti': 'Anggota',
    'Ni Made Jero': 'Anggota',
    'Putu Eni Arwati': 'Anggota',
    'Ni Made Wartini': 'Anggota',
    'Ni Komang Sukerti': 'Anggota',
    'Desak Sulastri': 'Anggota',
    'Putu Kawi': 'Anggota',
    'Ketut Esti Setia Purnama Dewi': 'Anggota',
    'Made Dwittari Pande': 'Anggota',
    'Ni Komang Budikertiasih': 'Anggota',
    'Ni Luh Putu Erna Purnama Wardani': 'Anggota',
    'Luh Mini': 'Anggota',
    'Ni Luh Duriani Pande': 'Anggota',
    'Luh Swinadi': 'Anggota',
    'Komang Desy Ariani': 'Anggota',
    'Made Budiayu': 'Anggota',
    'Kadek Purnami': 'Anggota',
    'Ni Kadek Elfira Meirosa Perasi': 'Anggota',
    'Ketut Kartika': 'Anggota',
    'Ketut Evin Handayanti': 'Anggota',
    'Komang Ariani': 'Anggota',
    'Ketut Suandayani': 'Anggota',
    'Jro Nyoman Sudarbi': 'Anggota',
    'Kadek Dewi Indrayani': 'Anggota',
    'Ketut Setia Wati': 'Anggota',
    'Gusti Ayu Dewi Pujayani': 'Anggota',
    'Komang Siti Suryani': 'Anggota',
    'Luh Alit Mahendra Wati': 'Anggota',
    'Kadek Suartini': 'Anggota',
    'Komang Intan Suryani': 'Anggota',
    'Kadek Desy Arisandi': 'Anggota',
    'Luh Anita': 'Anggota',
    'Luh Budartini': 'Anggota',
    'Komang Suardeni': 'Anggota',
    'Komang Asrini': 'Anggota',
    'Gusti Ayu Ketut Armeni': 'Anggota',
    'Nyoman Sariani': 'Anggota',
    'Wayan Karini': 'Anggota',
    'Ni Kadek Rasmini': 'Anggota',
    'Komang Ardiani': 'Anggota',
    'Luh Juliantini': 'Anggota',
    'Kadek Desi': 'Anggota',
    'Luh Setiani': 'Anggota',
    'Ketut Suanda Yani': 'Anggota',
    'Kadek Suarmini': 'Anggota',
  };

  final List<String> jenisKegiatanOptions = [
    'Bersih-bersih',
    '17 Agustus',
    'Makan-makan',
    'Arisan',
    'P2k (Iuran beras/gelas)'
  ];

  InputAbsensiPage({
    required this.selectedDate,
    required this.kegiatan,
    required this.tanggalController,
    required TextEditingController kegiatanController,
    this.jenisKegiatan,
    required Absensi absensi,
  });

  get anggotaOptions => null;

  @override
  _InputAbsensiPageState createState() => _InputAbsensiPageState();
}

class _InputAbsensiPageState extends State<InputAbsensiPage> {
  late TextEditingController namaController;
  late TextEditingController jabatanController;
  late TextEditingController alasanTidakHadirController;
  bool hadir = false;
  bool tidakHadir = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController();
    jabatanController = TextEditingController();
    alasanTidakHadirController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredAnggota = widget.namaAnggotaOptions.where((nama) {
      return nama.toLowerCase().contains(searchController.text.toLowerCase());
    }).toList();

    if (!filteredAnggota.contains(widget.selectedNamaAnggota)) {
      widget.selectedNamaAnggota = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Input Absensi"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Anggota",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: "Cari Anggota",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              DropdownButton<String>(
                value: widget.selectedNamaAnggota,
                onChanged: (newValue) {
                  setState(() {
                    widget.selectedNamaAnggota = newValue;
                    if (widget.jabatanMap.containsKey(newValue)) {
                      jabatanController.text = widget.jabatanMap[newValue]!;
                    }
                  });
                },
                items: filteredAnggota.map((String value) {
                  String category = '';
                  if (value.startsWith('POKJA')) {
                    category = 'POKJA';
                  } else if (value.contains('MEMBIDANGI')) {
                    category = 'MEMBIDANGI';
                  }
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: category == 'POKJA' || category == 'MEMBIDANGI'
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                isExpanded: true,
                hint: Text('Pilih Anggota'),
              ),
              SizedBox(height: 16.0),
              Text(
                "Jabatan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: jabatanController,
                decoration: InputDecoration(
                  labelText: "",
                  hintText: "Masukkan Jabatan",
                  labelStyle: TextStyle(color: Colors.pink),
                  prefixIcon: Icon(Icons.work),
                ),
              ),
              Text(
                "Jenis Kegiatan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: widget.jenisKegiatan,
                onChanged: (newValue) {
                  setState(() {
                    widget.jenisKegiatan = newValue;
                  });
                },
                items: widget.jenisKegiatanOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                hint: Text('Pilih Jenis Kegiatan'),
              ),
              SizedBox(height: 16.0),
              Text(
                "Tanggal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: widget.tanggalController,
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != widget.selectedDate) {
                    setState(() {
                      widget.selectedDate = pickedDate;
                      widget.tanggalController.text =
                          pickedDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: "",
                  hintText: "Pilih Tanggal",
                  labelStyle: TextStyle(color: Colors.pink),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Kehadiran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Checkbox(
                    value: hadir,
                    onChanged: (value) {
                      setState(() {
                        hadir = value!;
                        tidakHadir = false;
                      });
                    },
                  ),
                  Text("Hadir"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: tidakHadir,
                    onChanged: (value) {
                      setState(() {
                        tidakHadir = value!;
                        hadir = false;
                      });
                    },
                  ),
                  Text("Tidak Hadir"),
                ],
              ),
              if (tidakHadir)
                Text(
                  "Alasan Tidak Hadir",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              if (tidakHadir)
                TextFormField(
                  controller: alasanTidakHadirController,
                  decoration: InputDecoration(
                    labelText: "",
                    hintText: "Masukkan Alasan Tidak Hadir",
                    labelStyle: TextStyle(color: Colors.pink),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String nama = widget.selectedNamaAnggota ?? '';
          String jabatan = jabatanController.text;
          String alasanTidakHadir =
              tidakHadir ? alasanTidakHadirController.text : '';

          Navigator.pop(
            context,
            Absensi(
              nama: nama,
              jabatan: jabatan,
              hadir: '',
              tidakHadir: '',
              kegiatan: widget.jenisKegiatan ?? "",
              tanggal: widget.selectedDate,
              alasanTidakHadir: alasanTidakHadir,
            ),
          );
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.pink,
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    jabatanController.dispose();
    super.dispose();
  }
}

// // class Absensi {
//   final String nama;
//   final String jabatan;
//   final bool hadir;
//   final bool tidakHadir;
//   final String kegiatan;
//   final DateTime tanggal;
//   final String alasanTidakHadir;

//   Absensi({
//     required this.nama,
//     required this.jabatan,
//     required this.hadir,
//     required this.tidakHadir,
//     required this.kegiatan,
//     required this.tanggal,
//     required this.alasanTidakHadir,
//   });
// }

void main() {
  runApp(MaterialApp(
    home: InputAbsensiPage(
      selectedDate: DateTime.now(),
      kegiatan: "Kegiatan Contoh",
      tanggalController: TextEditingController(),
      kegiatanController: TextEditingController(),
      absensi: Absensi(
        nama: "",
        jabatan: "",
        hadir: '',
        tidakHadir: '',
        kegiatan: "",
        tanggal: DateTime.now(),
        alasanTidakHadir: "",
      ),
    ),
  ));
}
