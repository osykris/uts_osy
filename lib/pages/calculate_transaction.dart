import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uts_osy/models/calculate.dart';

// ignore: must_be_immutable
class CalculateTransaction extends StatefulWidget {
  @override
  _CalculateTransactionState createState() => _CalculateTransactionState();
}

class _CalculateTransactionState extends State<CalculateTransaction> {
  TextEditingController namaC = TextEditingController();

  TextEditingController hargaC = TextEditingController();

  TextEditingController jumlahC = TextEditingController();

  final minimumPadding = 5.0;

  final List<Calculate> Carts = [];

  void SaveItem() {
    // fungsi untuk menyimpan inputan user
    final name = namaC.text;
    final price = int.parse(hargaC.text);
    final qty = int.parse(jumlahC.text);

    if (name.isEmpty || price == 0 || qty == 0) {
      // kondisi jika kosong tidak mengembalikan apa2
      return;
    }
    _tambahItemBaru(name, price, qty);
  }

  void _tambahItemBaru(String name, int price, int qty) {
    var product = Calculate(
        id: DateTime.now().toString(), name: name, price: price, quantity: qty);
    setState(() {
      Carts.add(product);
    });
  }

  void _resetCarts() {
    setState(() {
      Carts.clear();
    });
  }

  int get jumlah {
    // fungsi untuk menghitung jumlah quntity pada listview
    return Carts.fold(0, (sum, item) {
      return sum += item.quantity;
    });
  }

  int get totalPrice {
    // fungsi untuk menghitung jumlah hargapada listview
    return Carts.fold(0, (sum, item) {
      int jumlah_harga = item.quantity * item.price;
      return sum += jumlah_harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculate Transactions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 29, right: 10, left: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: minimumPadding,
                  ),
                  child: TextField(
                    controller: namaC,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "e.g: Indomie",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: minimumPadding,
                    bottom: minimumPadding,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: hargaC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Price",
                              hintText: "e.g: 2000",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      Container(
                        width: minimumPadding * 2,
                      ),
                      Container(
                        width: minimumPadding * 20,
                        child: TextField(
                          controller: jumlahC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Quantity",
                              hintText: "e.g: 4",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.cyan,
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: SaveItem,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Calculation History",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            )),
                        FlatButton(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _resetCarts(),
                        )
                      ],
                    )),
                Container(
                  height: 80,
                  margin: EdgeInsets.all(8),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Total Purchase    : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  jumlah.toString() +
                                      " pcs ", // memanggil fungsi jumlah untuk menampilkanya
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Total Price            : ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Rp. ' +
                                      totalPrice.toStringAsFixed(
                                          0), // memanggil fungsi jumlahHarga untuk menampilkanya
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    height: 100,
                    child: Carts.isEmpty
                        ? Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 10),
                                child: Text("------No History------",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan)),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: Carts.length,
                            itemBuilder: (context, index) {
                              int totalPrice =
                                  Carts[index].price * Carts[index].quantity;
                              return Card(
                                elevation: 10,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        Carts[index].quantity.toString(),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Name - ' + Carts[index].name,
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                              'Price           : Rp. ' +
                                                  Carts[index]
                                                      .price
                                                      .toStringAsFixed(0),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                          Text(
                                              'Quantity     : ' +
                                                  Carts[index]
                                                      .quantity
                                                      .toStringAsFixed(0) +
                                                  ' pcs',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
