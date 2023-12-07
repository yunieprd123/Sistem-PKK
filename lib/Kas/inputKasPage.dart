import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KasUmumModel {
  int id;
  String keterangan;
  int jumlah;
  DateTime tanggal;
  bool isPemasukan;

  KasUmumModel({
    required this.id,
    required this.keterangan,
    required this.jumlah,
    required this.tanggal,
    required this.isPemasukan,
  });
}

class InputKasPage extends StatefulWidget {
  @override
  _InputKasPageState createState() => _InputKasPageState();
}

class _InputKasPageState extends State<InputKasPage> {
  List<KasUmumModel> _dataKasUmum = [];
  int _nextId = 1;

  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  bool _isPemasukan = true;
  DateTime _selectedDate = DateTime.now();
  bool _isAddingNewData = false;

  String formatRupiah(int amount) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return currencyFormat.format(amount);
  }

  void tambahKasUmum(KasUmumModel kasUmum) {
    kasUmum.id = _nextId;
    setState(() {
      _dataKasUmum.add(kasUmum);
      _nextId++;
    });
  }

  void ubahKasUmum(int id, KasUmumModel kasUmumBaru) {
    final index = _dataKasUmum.indexWhere((kas) => kas.id == id);
    if (index != -1) {
      setState(() {
        _dataKasUmum[index] = kasUmumBaru;
      });
    }
  }

  void hapusKasUmum(int id) {
    setState(() {
      _dataKasUmum.removeWhere((kas) => kas.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Kas Umum"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _dataKasUmum.length,
              itemBuilder: (context, index) {
                final kasUmum = _dataKasUmum[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text("Keterangan: ${kasUmum.keterangan}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jumlah: ${formatRupiah(kasUmum.jumlah)}"),
                          Text(
                            "Tanggal: ${DateFormat('dd MMMM yyyy').format(kasUmum.tanggal)}",
                          ),
                          Text(
                            "Jenis: ${kasUmum.isPemasukan ? 'Pemasukan' : 'Pengeluaran'}",
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          hapusKasUmum(kasUmum.id);
                        },
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildDataDialog(context, kasUmum);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildDataDialog(context, null);
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add),
      ),
    );
  }

  AlertDialog _buildDataDialog(BuildContext context, KasUmumModel? kasUmum) {
    final isEditing = kasUmum != null;
    _isAddingNewData = !isEditing;

    _keteranganController.text = kasUmum?.keterangan ?? '';
    _jumlahController.text = formatRupiah(kasUmum?.jumlah ?? 0);
    _isPemasukan = kasUmum?.isPemasukan ?? true;

    return AlertDialog(
      title: Text(isEditing ? "Edit Data Kas Umum" : "Tambah Data Kas Umum"),
      content: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  labelText: "Keterangan",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: TextField(
                controller: _jumlahController,
                decoration: InputDecoration(
                  labelText: "Jumlah Uang",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monetization_on),
                  suffixText: "Rp",
                ),
                onChanged: (value) {
                  final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
                  setState(() {
                    if (cleanValue.isNotEmpty) {
                      final intValue = int.tryParse(cleanValue) ?? 0;
                      _jumlahController.text = formatRupiah(intValue);
                    }
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                children: <Widget>[
                  Text("Jenis:"),
                  Radio(
                    value: true,
                    groupValue: _isPemasukan,
                    onChanged: (value) {
                      setState(() {
                        _isPemasukan = true;
                      });
                    },
                  ),
                  Text("Pemasukan"),
                  Radio(
                    value: false,
                    groupValue: _isPemasukan,
                    onChanged: (value) {
                      setState(() {
                        _isPemasukan = false;
                      });
                    },
                  ),
                  Text("Pengeluaran"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child:
                  Text('Pilih Tanggal', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Batal"),
        ),
        TextButton(
          onPressed: () {
            final keterangan = _keteranganController.text;
            final jumlah = int.tryParse(
                  _jumlahController.text.replaceAll(RegExp('[^0-9]'), ''),
                ) ??
                0;

            if (keterangan.isNotEmpty && jumlah > 0) {
              final kasUmumBaru = KasUmumModel(
                id: isEditing ? kasUmum.id : 0,
                keterangan: keterangan,
                jumlah: jumlah,
                tanggal: _selectedDate,
                isPemasukan: _isPemasukan,
              );
              if (isEditing) {
                ubahKasUmum(kasUmum.id, kasUmumBaru);
              } else {
                tambahKasUmum(kasUmumBaru);
              }
              Navigator.pop(context);
              _keteranganController.clear();
              _jumlahController.clear();
            }
          },
          child: Text("Simpan"),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    )) as DateTime;

    setState(() {
      _selectedDate = picked;
    });
    }
}

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      home: InputKasPage(),
    ));
