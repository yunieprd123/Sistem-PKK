import 'package:flutter/material.dart';
import 'package:kebaya_boutiq/home_page.dart';
import 'package:kebaya_boutiq/widgets/info_card.dart';

const email = "me.budiayu123@gmail.com";
const phone = "+62 81939522324";
const location = "Jl. Raya Air Sanih";

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String editedName = "Ni Made Budi Ayu"; // Default nama
  String editedEmail = "me.budiayu123@gmail.com"; // Default email
  String editedPhone = phone; // Default nomor telepon
  String editedLocation = location; // Default alamat

  // Controller untuk mengontrol input yang diedit
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    nameController.text = editedName;
    emailController.text = editedEmail;
    phoneController.text = editedPhone;
    locationController.text = editedLocation;
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveChanges() {
    setState(() {
      editedName = nameController.text;
      editedEmail = emailController.text;
      editedPhone = phoneController.text;
      editedLocation = locationController.text;
      toggleEditing();
    });
    Navigator.of(context).pop(); // Tutup dialog setelah menyimpan perubahan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          },
        ),
        backgroundColor: Colors.pink[200],
        elevation: 0,
        actions: [
          if (!isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: toggleEditing,
            )
          else
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Simpan Perubahan"),
                      content:
                          Text("Apakah Anda yakin ingin menyimpan perubahan?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Batal"),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Tutup dialog konfirmasi
                          },
                        ),
                        TextButton(
                          child: Text("Simpan"),
                          onPressed: () {
                            saveChanges();
                            Navigator.of(context)
                                .pop(); // Tutup dialog konfirmasi
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/logo google.png'),
              ),
              Text(
                isEditing ? 'Edit Profil' : editedName,
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Anggota PKK",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.amber[50],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(color: Colors.white),
              ),
              InfoCard(
                text: "Telepon",
                icon: Icons.phone,
                onPressed: () async {
                  if (isEditing) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Edit Telepon"),
                          content: TextField(
                            controller: phoneController,
                            decoration:
                                InputDecoration(hintText: "Nomor Telepon"),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Simpan"),
                              onPressed: () {
                                saveChanges();
                              },
                            ),
                            TextButton(
                              child: Text("Batal"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Tutup dialog edit telepon
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              InfoCard(
                text: "Email",
                icon: Icons.mail,
                onPressed: () async {
                  if (isEditing) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Edit Email"),
                          content: TextField(
                            controller: emailController,
                            decoration:
                                InputDecoration(hintText: "Alamat Email"),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Simpan"),
                              onPressed: () {
                                saveChanges();
                              },
                            ),
                            TextButton(
                              child: Text("Batal"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Tutup dialog edit email
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              InfoCard(
                text: "Alamat",
                icon: Icons.location_city,
                onPressed: () async {
                  if (isEditing) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Edit Alamat"),
                          content: TextField(
                            controller: locationController,
                            decoration: InputDecoration(hintText: "Alamat"),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Simpan"),
                              onPressed: () {
                                saveChanges();
                              },
                            ),
                            TextButton(
                              child: Text("Batal"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Tutup dialog edit alamat
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              if (isEditing)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: "Nama"),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(labelText: "Telepon"),
                      ),
                      TextField(
                        controller: locationController,
                        decoration: InputDecoration(labelText: "Alamat"),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
