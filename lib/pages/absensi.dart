import 'package:flutter/material.dart';
import 'package:kebaya_boutiq/service/apiAbsensi.dart';
import 'inputabsensi.dart';
import 'Absensi_Models.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController kegiatanController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  List<Absensi> absensiAnggota = [
    Absensi(
      nama: 'nama',
      jabatan: 'jabatan',
      hadir: '',
      tidakHadir: '',
      kegiatan: 'kegiatan',
      tanggal: DateTime.now(),
      alasanTidakHadir: 'alasanTidakHadir',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Absensi Anggota PKK Desa Kubutambahan"),
        backgroundColor: Colors.pink,
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder<List<Absensi>>(
            future: ApiAbsensi.getAbsensi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(
                    'Error fetching data: ${snapshot.error.toString()}');
              } else {
                List<Absensi>? absensiAnggota = snapshot.data;

                return ListView.builder(
                  itemCount: absensiAnggota?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          absensiAnggota![index].nama,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              absensiAnggota[index].jabatan,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Icon(
                                  absensiAnggota[index].hadir == 'true'
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: absensiAnggota[index].hadir == 'true'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  absensiAnggota[index].hadir == 'true'
                                      ? "Hadir"
                                      : "Tidak Hadir",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: absensiAnggota[index].hadir == 'true'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            if (absensiAnggota[index].hadir == 'false')
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alasan Tidak Hadir: ${absensiAnggota[index].alasanTidakHadir}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            Text(
                              "Kegiatan: ${absensiAnggota[index].kegiatan}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tanggal: ${absensiAnggota[index].tanggal.toLocal().toString().split(' ')[0]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InputAbsensiPage(
                                      selectedDate: DateTime.now(),
                                      kegiatanController: kegiatanController,
                                      tanggalController: tanggalController,
                                      kegiatan: '',
                                      absensi: absensiAnggota[index],
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    absensiAnggota[index] = result;
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  absensiAnggota.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputAbsensiPage(
                selectedDate: DateTime.now(),
                kegiatanController: kegiatanController,
                tanggalController: tanggalController,
                kegiatan: '',
                absensi: Absensi(
                  nama: '',
                  jabatan: '',
                  hadir: 'false',
                  tidakHadir: 'false',
                  tanggal: DateTime.now(),
                  kegiatan: '',
                  alasanTidakHadir: '',
                ),
              ),
            ),
          );

          if (result != null) {
            setState(() {
              absensiAnggota.add(result);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
