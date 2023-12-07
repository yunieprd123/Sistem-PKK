import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Anggota/dataanggota.dart';
import 'package:kebaya_boutiq/pages/absensi.dart';
import 'Kalender/kalender.dart';
import 'Kas/inputKasPage.dart';
import 'keuangan/inputiuran.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 215, 103, 150),
        title: Text('Sistem PKK Desa Kubutambahan'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 215, 103, 150)),
              accountName: Text('Ni Made Budi Ayu'),
              accountEmail: Text('budiayu123@gmail.com'),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  // Navigasi ke halaman profil
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/sekretaris.jpg'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people_alt_outlined),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                // Navigasi ke halaman profil
              },
            ),
            ListTile(
              leading: Icon(Icons.volunteer_activism_outlined),
              title: Text(
                'Visi Misi',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                // Navigasi ke halaman visi misi
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                // Navigasi ke halaman logout
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    color: Color.fromARGB(255, 215, 103, 150),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Selamat Datang di Sistem PKK Desa  Kubutambahan",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  cursorHeight: 20,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: "Cari Anggota",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    onSearchPressed();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Category(
                      imagePath: "assets/team.png",
                      title: "Anggota",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnggotaList(),
                          ),
                        );
                      },
                    ),
                    Category(
                      imagePath: "assets/save-time.png",
                      title: "Iuran",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputIuranPage(
                                // iuran: Iuran(
                                //   jenisKegiatan: '',
                                //   nama: '',
                                //   nominalUang: 0, // Isi dengan nilai yang sesuai
                                //   buktiPembayaranPath: '',
                                //   // Isi properti-properti objek Iuran sesuai dengan kebutuhan
                                // ),
                                // totalKeuangan:
                                //     0.0, // Gantilah dengan nilai yang sesuai
                                ),
                          ),
                        );
                      },
                    ),
                    Category(
                      imagePath: "assets/attendance.png",
                      title: "Absensi",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionPage(),
                          ),
                        );
                      },
                    ),
                    Category(
                      imagePath: "assets/schedule.png",
                      title: "Kalender",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Calendar(),
                          ),
                        );
                      },
                    ),
                    Category(
                      imagePath: "assets/passbook.png",
                      title: "Kas",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputKasPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Carousel section
              CarouselSlider(
                items: [
                  PlantShop(
                    imagePath: "assets/ketua.jpeg",
                    nameShop: "Ketua",
                    onTap: () {
                      // Navigasi ke halaman anggota saat item diklik.
                    },
                  ),
                  PlantShop(
                    imagePath: "assets/wakil.jpeg",
                    nameShop: "Wakil",
                    onTap: () {
                      // Navigasi ke halaman anggota saat item diklik.
                    },
                  ),
                  PlantShop(
                    imagePath: "assets/sekretaris.jpg",
                    nameShop: "Sekretaris",
                    onTap: () {
                      // Navigasi ke halaman anggota saat item diklik.
                    },
                  ),
                  PlantShop(
                    imagePath: "assets/bendahara.jpeg",
                    nameShop: "Bendahara",
                    onTap: () {
                      // Navigasi ke halaman anggota saat item diklik.
                    },
                  ),
                ],
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSearchPressed() {
    String searchText = searchController.text;
    // Lakukan sesuatu dengan searchText, misalnya navigasi ke hasil pencarian
    print('Searching for: $searchText');
  }
}

class PlantShop extends StatelessWidget {
  final String imagePath;
  final String nameShop;
  final VoidCallback onTap;

  const PlantShop({
    Key? key,
    required this.imagePath,
    required this.nameShop,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: SizedBox(
                height: 30,
                child: Column(
                  children: [
                    Text(
                      nameShop,
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onPressed;

  const Category({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Container(
          width: 50,
          height: 60,
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 30,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: GoogleFonts.montserrat(fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
