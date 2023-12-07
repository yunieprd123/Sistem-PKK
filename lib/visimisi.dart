import 'package:flutter/material.dart';

class VisiMisiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visi dan Misi Desa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pkk.jpeg', // Ganti dengan path ikon visi
              width: 300, // Ubah lebar gambar sesuai kebutuhan Anda
              height: 100, // Ubah tinggi gambar sesuai kebutuhan Anda
            ),
            SizedBox(height: 20),
            Text(
              'Visi PKK Desa Kubutambahan',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold), // Tambahkan fontWeight
              textAlign: TextAlign.center, // Tengahkan teks
            ),
            SizedBox(height: 10),
            Text(
              '"Melanjutkan untuk mewujudkan desa Kubutambahan yang BALINS":\n\n1. Mewujudkan desa Kubutambahan yang BERSIH dari sampah\n2. Memberikan rasa AMAN bagi masyarakat desa Kubutambahan\n3. Melestarikan adat istiadat dan kebudayaan desa Kubutambahan agar tetap LESTARI\n4. Terciptanya suasana INDAH di setiap sudut desa dan Membiasakan masyarakat Desa Kubutambahan agar tetap hidup SEDERHANA dengan berlandasan TRI HITA KARANA.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            // Image.asset(
            //   'assets/pkk2.jpeg', // Ganti dengan path ikon misi
            //   width: 100,
            //   height: 100,
            // ),
            SizedBox(height: 20),
            Text(
              'Misi',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold), // Tambahkan fontWeight
              textAlign: TextAlign.center, // Tengahkan teks
            ),
            SizedBox(height: 10),
            Text(
              'Agar Visi sebagaimana tersebut dapat tercapai maka ditetapkan Misi sebagai berikut:\n\n1. Menata Aparatur Pemerintahan Desa Kubutambahan sehingga dapat melaksanakan tugas sesuai dengan tugas pokoknya masing-masing;\n2. Membina dan menciptakan kerukunan masyarakat desa Kubutambahan secara netral dan mandiri;\n3. Meningkatkan peran serta pemuda dan remaja dibidang pembangunan, olahraga, seni dan kemasyarakatan;\n4. Meningkatkan dan memotivasi kegiatan keagamaan terutama kegiatan muslimat desa Kubutambahan;\n5. Meningkatkan sarana dan prasarana umum sesuai dengan aspirasi masyarakat.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
