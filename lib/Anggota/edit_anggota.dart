import 'package:flutter/material.dart';

class EditAnggota extends StatefulWidget {
  final Map<String, String>? anggota;
  final Function(Map<String, String>) onSave;
  final Function()? onDelete;
  final List<String> daftarJabatan;
  final List<String> daftarPokja;

  EditAnggota({
    this.anggota,
    required this.onSave,
    this.onDelete,
    required this.daftarJabatan,
    required this.daftarPokja,
  });

  @override
  _EditAnggotaState createState() => _EditAnggotaState();
}

class _EditAnggotaState extends State<EditAnggota> {
  TextEditingController _namaController = TextEditingController();
  String _jabatanDropdownValue = '';
  String _pokjaDropdownValue = '';
  String _status = 'Aktif';

  @override
  void initState() {
    super.initState();
    if (widget.anggota != null) {
      _namaController.text = widget.anggota!['nama']!;
      _jabatanDropdownValue = widget.anggota!['jabatan']!;
      _pokjaDropdownValue = widget.anggota!['pokja']!;
      _status = widget.anggota!['status']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Anggota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            DropdownButtonFormField<String>(
              value: _jabatanDropdownValue,
              items: widget.daftarJabatan.map((String jabatan) {
                return DropdownMenuItem<String>(
                  value: jabatan,
                  child: Text(jabatan),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _jabatanDropdownValue = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Jabatan'),
            ),
            DropdownButtonFormField<String>(
              value: _pokjaDropdownValue,
              items: widget.daftarPokja.map((String pokja) {
                return DropdownMenuItem<String>(
                  value: pokja,
                  child: Text(pokja),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _pokjaDropdownValue = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'POKJA'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Status: Aktif'),
                Radio(
                  value: 'Aktif',
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                Text('Tidak Aktif'),
                Radio(
                  value: 'Tidak Aktif',
                  groupValue: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String nama = _namaController.text;

                if (nama.isNotEmpty && _jabatanDropdownValue.isNotEmpty && _pokjaDropdownValue.isNotEmpty) {
                  final Map<String, String> editedAnggota = {
                    'nama': nama,
                    'jabatan': _jabatanDropdownValue,
                    'pokja': _pokjaDropdownValue,
                    'status': _status,
                  };

                  widget.onSave(editedAnggota);
                  Navigator.pop(context);
                } else {
                  // Tampilkan pesan kesalahan jika ada isian yang kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Harap lengkapi semua isian.'),
                      backgroundColor: Colors.red, // Warna latar merah
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            ),
            if (widget.onDelete != null && widget.anggota != null)
              ElevatedButton(
                onPressed: () {
                  widget.onDelete!(); // Hapus anggota
                  Navigator.pop(context);
                },
                child: Text('Hapus'),
              ),
          ],
        ),
      ),
    );
  }
}