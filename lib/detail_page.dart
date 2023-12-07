import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: height * 0.3,
                width: widht,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/PKK.jpeg"))),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "RAPAT RUTIN TP-PKK DESA KUBUTAMBAHAN",
                    style: GoogleFonts.montserrat(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                height: height * .12,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
            ],
          ),
          TitleAbout(
            title: "DESKRIPSI BERITA",
            about:
                "Pemerintahan Desa Kubutambahan melaksanakan Kegiatan rapat Rutin TP PKK Desa Kubutambahan.Rapat TP PKK rutin Bulanan ini di gelar dengan tujuan membahas dan mengevaluasi berbagai hal seperti kegiatan setiap kelompok kerja (Pokja) serta memperoleh pembinaan dan berbagai informasi terkait dengan rencana kegiatan PKK untuk ke depannya di tahun 2023..",
          ),
          TitleAbout(
              title: "TUJUAN KEGIATAN",
              about:
                  "Rapat ini memberikan kesempatan kepada setiap kelompok kerja (Pokja) di dalam TP PKK Desa untuk menyampaikan laporan mengenai kegiatan yang telah dilaksanakan selama bulan tersebut. Hal ini memungkinkan para anggota Pokja untuk berbagi informasi, pengalaman, dan hasil kerja mereka."),
          TitleAbout(
              title: "TEMPAT-TGL KEGIATAN",
              about:
                  "Jumat, 16 Juni 2023 bertempat di Kantor Desa Kubutambahan"),
        ],
      )),
    ));
  }
}

class TitleAbout extends StatelessWidget {
  final String title;
  final String about;
  const TitleAbout({
    super.key,
    required this.title,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            about,
            style: GoogleFonts.montserrat(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
