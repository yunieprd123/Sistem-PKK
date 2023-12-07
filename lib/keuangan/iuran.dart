import 'dart:io';
import 'package:flutter/material.dart';
import 'Iuran_Models.dart';
import 'package:intl/intl.dart';

class IuranPage extends StatelessWidget {
  final Iuran iuran;
  final String? buktiPembayaran;
  final double totalKeuangan;

  IuranPage({
    required this.iuran,
    this.buktiPembayaran,
    required this.totalKeuangan,
  });

  String formatRupiah(double nominal) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 2);
    return formatter.format(nominal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Iuran'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama: ${iuran.nama}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(height: 20, thickness: 2),
                  Text('Jenis Kegiatan: ${iuran.jenisKegiatan}'),
                  Divider(height: 20, thickness: 2),
                  Text(
                      'Nominal Uang: ${formatRupiah(iuran.nominalUang as double)}'),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (buktiPembayaran != null)
              Image.file(
                File(buktiPembayaran!),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Total Keuangan'),
                      content: Text(
                        formatRupiah(totalKeuangan),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Total Dana: ${formatRupiah(totalKeuangan)}'),
            ),
          ],
        ),
      ),
    );
  }
}
