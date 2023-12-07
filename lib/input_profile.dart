import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController emailController = TextEditingController();
  String newEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Implementasikan pemilihan gambar profil di sini
                },
                child: CircleAvatar(
                  radius: 60,
                  // Ganti dengan gambar profil yang sudah ada
                  backgroundImage: AssetImage('assets/logo google.png'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Alamat Email:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Alamat Email Baru",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Simpan perubahan alamat email ke newEmail
                  setState(() {
                    newEmail = emailController.text;
                  });

                  // Implementasikan penyimpanan perubahan foto profil dan email ke database atau penyimpanan lainnya
                  // ...

                  // Kembali ke halaman profil
                  Navigator.pop(context);
                },
                child: Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
