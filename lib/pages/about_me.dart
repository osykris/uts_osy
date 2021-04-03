import 'package:flutter/material.dart';

//pendukung program asinkron
class About_Me extends StatefulWidget {
  @override
  About_MeState createState() => About_MeState();
}

class About_MeState extends State<About_Me> {
  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Me',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        leading: new IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/top_header.png')),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 20, left: 75, top: 50),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage('assets/images/admin.jpg'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      "OSY KRISDAYANTI",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Montserrat Regular",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "Saya seorang mahasiswa dari jurusan Teknologi Informasi program studi DIII Manajemen Informatika kelas 2C Politeknik Negeri Malang, Rumah saya di Kabupaten Blitar. Saya membuat sebuah aplikasi Finnancial Planning untuk memudahkan seseorang dalam merencanakan keuangan serta aplikasi ini untuk memenuhi nilai UTS mata kuliah Pemrograman Mobile",
                      style: TextStyle(
                          fontSize: 14, fontFamily: "Montserrat Regular"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
