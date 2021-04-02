import 'package:flutter/material.dart';
import 'package:uts_osy/db_helper.dart';
import 'package:uts_osy/models/product.dart';

class Entry_Product extends StatefulWidget {
  final Product product;
  Entry_Product(this.product);
  @override
  Entry_ProductState createState() => Entry_ProductState(this.product);
}

//class controller
class Entry_ProductState extends State<Entry_Product> {
  DbHelper dbHelper = DbHelper();
  Product product;
  Entry_ProductState(this.product);
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //kondisi
    bool check = false;
    if (product != null) {
      nameController.text = product.name;
      quantityController.text = product.quantity.toString();
      priceController.text = product.price.toString();
      check = true;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: product == null
              ? Text('New Planning',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24))
              : Text('Edit',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
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
        body: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              // quantity
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              // harga
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Colors.cyan,
                        textColor: Colors.white,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (product == null) {
                            product = Product(
                                nameController.text,
                                int.parse(quantityController.text),
                                int.parse(priceController.text));
                          } else {
                            product.name = nameController.text;
                            product.quantity =
                                int.parse(quantityController.text);
                            product.price = int.parse(priceController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek perencanaan
                          Navigator.pop(context, product);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Colors.cyan,
                        textColor: Colors.white,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
