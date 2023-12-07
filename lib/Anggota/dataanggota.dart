import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Anggota {
  String nama;
  String jabatan;
  String pokja;
  File? image;
  bool status;

  Anggota({
    required this.nama,
    required this.jabatan,
    required this.pokja,
    this.image,
    this.status = true,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Susunan Keanggotaan PKK',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: AnggotaList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnggotaList extends StatefulWidget {
  @override
  _AnggotaListState createState() => _AnggotaListState();
}

class _AnggotaListState extends State<AnggotaList> {
  List<Anggota> _anggotaList = [
    Anggota(
      nama: 'CARMELINDA CARVALHO',
      jabatan: 'KETUA',
      pokja: 'POKJA I',
      image: null,
      status: true,
    ),
    // Tambahkan anggota lainnya
  ];

  List<String> _jabatanList = ['KETUA', 'WAKIL', 'SEKRETARIS', 'ANGGOTA'];
  List<String> _pokjaList = ['POKJA I', 'POKJA II', 'POKJA III'];

  void _tambahAnggotaDialog() {
    TextEditingController _namaController = TextEditingController();
    String _selectedJabatan = _jabatanList[0];
    String _selectedPokja = _pokjaList[0];
    File? _selectedImage;

    showDialog(
      context: context,
      builder: (context) {
        bool _status = true; // Default status saat menambah anggota

        return AlertDialog(
          title: Text('Tambah Anggota'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedJabatan,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedJabatan = newValue!;
                  });
                },
                items: _jabatanList.map((String jabatan) {
                  return DropdownMenuItem<String>(
                    value: jabatan,
                    child: Text(jabatan),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Jabatan'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedPokja,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPokja = newValue!;
                  });
                },
                items: _pokjaList.map((String pokja) {
                  return DropdownMenuItem<String>(
                    value: pokja,
                    child: Text(pokja),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'POKJA'),
              ),
              Row(
                children: [
                  Text('Status Aktif:'),
                  Switch(
                    value: _status,
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Text('Pilih gambar'),
              ElevatedButton(
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  final XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
                child: Text('Pilih Gambar'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                final String nama = _namaController.text;
                if (nama.isNotEmpty) {
                  final Anggota newAnggota = Anggota(
                    nama: nama,
                    jabatan: _selectedJabatan,
                    pokja: _selectedPokja,
                    image: _selectedImage,
                    status: _status,
                  );
                  _tambahAnggota(newAnggota);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _hapusAnggota(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Anggota'),
          content: Text('Apakah Anda yakin ingin menghapus anggota ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _anggotaList.removeAt(index);
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Susunan Keanggotaan PKK'),
      ),
      body: ListView.builder(
        itemCount: _anggotaList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_anggotaList[index].nama),
            onDismissed: (direction) {
              _hapusAnggota(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: _buildAnggotaItem(_anggotaList[index], index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahAnggotaDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAnggotaItem(Anggota anggota, int index) {
    return ListTile(
      title: Text(
        anggota.jabatan,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(anggota.nama),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon:
                anggota.status ? Icon(Icons.check) : Icon(Icons.close_rounded),
            onPressed: () {
              setState(() {
                anggota.status = !anggota.status;
              });
            },
          ),
          // Tambahkan widget lain di sini jika diperlukan
        ],
      ),
      leading: anggota.image != null
          ? CircleAvatar(
              radius: 30,
              backgroundImage: FileImage(anggota.image!),
            )
          : CircleAvatar(
              radius: 30,
              child: Text(anggota.nama[
                  0]), // Menampilkan huruf pertama nama jika tidak ada gambar
            ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditAnggota(
              anggota: anggota,
              onSave: (editedAnggota) {
                _editAnggota(editedAnggota, index);
              },
              jabatanList: _jabatanList,
              pokjaList: _pokjaList,
            ),
          ),
        );
      },
    );
  }

  void _tambahAnggota(Anggota anggota) {
    setState(() {
      _anggotaList.add(anggota);
    });
  }

  void _editAnggota(Anggota editedAnggota, int index) {
    setState(() {
      _anggotaList[index] = editedAnggota;
    });
  }
}

class EditAnggota extends StatefulWidget {
  final Anggota? anggota;
  final Function(Anggota) onSave;
  final List<String> jabatanList;
  final List<String> pokjaList;

  EditAnggota({
    this.anggota,
    required this.onSave,
    required this.jabatanList,
    required this.pokjaList,
  });

  @override
  _EditAnggotaState createState() => _EditAnggotaState();
}

class _EditAnggotaState extends State<EditAnggota> {
  TextEditingController _namaController = TextEditingController();
  String _selectedJabatan = '';
  String _selectedPokja = '';
  bool _isFormValid = true;
  bool _status = true; // Status aktif atau tidak aktif

  void _validateForm() {
    final String nama = _namaController.text;

    if (nama.isEmpty) {
      setState(() {
        _isFormValid = false;
      });
    } else {
      setState(() {
        _isFormValid = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.anggota != null) {
      _namaController.text = widget.anggota!.nama;
      _selectedJabatan = widget.anggota!.jabatan;
      _selectedPokja = widget.anggota!.pokja;
      _status = widget.anggota!.status;
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
              onChanged: (value) {
                _validateForm();
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedJabatan,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedJabatan = newValue!;
                });
              },
              items: widget.jabatanList.map((String jabatan) {
                return DropdownMenuItem<String>(
                  value: jabatan,
                  child: Text(jabatan),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Jabatan'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedPokja,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPokja = newValue!;
                });
              },
              items: widget.pokjaList.map((String pokja) {
                return DropdownMenuItem<String>(
                  value: pokja,
                  child: Text(pokja),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'POKJA'),
            ),
            Row(
              children: [
                Text('Status Aktif:'),
                Switch(
                  value: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
              ],
            ),
            if (!_isFormValid)
              Text(
                'Nama tidak boleh kosong',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () {
                      final String nama = _namaController.text;
                      final Anggota editedAnggota = Anggota(
                        nama: nama,
                        jabatan: _selectedJabatan,
                        pokja: _selectedPokja,
                        image: null,
                        status: _status,
                      );

                      widget.onSave(editedAnggota);
                      Navigator.pop(context);
                    }
                  : null,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
