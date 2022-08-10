import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uts_osy/pages/about_me.dart';
import 'package:uts_osy/pages/calculate_transaction.dart';
import 'package:uts_osy/pages/list_entry.dart';
import 'package:uts_osy/pages/list_products.dart';

class HomeScreen extends StatefulWidget {
  // pembuatan class HomeScreen yang memperluaskan statefullwidget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //pembuatan class _HomeScreenState yang mengextend State dari class HomeScreen
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
      body: Stack(
        children: <Widget>[
          Container(
            //banner
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
                  //banner yang ada gambar dan keterangan
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/admin.jpg'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Financial Planning',
                              style: TextStyle(
                                fontFamily: "Montserrat Medium",
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'OSY - 1931710075 MI2C',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: "Montserrat Regular"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // Berisi fitur fitur (dengan card yang nanti jika diklik akan menuju ke halaman selanjutnya)
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EntryEntry()),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 170,
                                    child: Image.asset(
                                        'assets/images/customers.png'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    'Money Entry',
                                    style: cardTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => List_Product()),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 100,
                                    child: Image.asset(
                                        'assets/images/products.png'),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    'Purchase Plan',
                                    style: cardTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //berisi text motivasi
          Padding(
            padding: const EdgeInsets.only(top: 515.0, left: 16, right: 16),
            child: Container(
                child: Text(
              "'Investasikan lagi keuntungan yang diperoleh untuk membangun aset dengan berinvestasi pada properti lainnya dan bukan membeli barang konsumtif.' - Joe Hartanto",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat Regular"),
            )),
          ),
        ],
      ),
    );
  }
}
