import 'package:flutter/material.dart';
import 'package:uts_osy/db_helper.dart';
import 'package:uts_osy/models/product.dart';

class Entry_Product extends StatefulWidget {
  final Product list;
  Entry_Product(this.list);
  @override
  Entry_ProductState createState() => Entry_ProductState(this.list);
}

//class controller
class Entry_ProductState extends State<Entry_Product> {
  Product list;
  DbHelper dbHelper = DbHelper();
  Entry_ProductState(this.list);
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (list != null) {
      nameController.text = list.name;
      quantityController.text = list.quantity.toString();
      priceController.text = list.price.toString();
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: list == null
              ? Text('New planning', style: TextStyle(color: Colors.white))
              : Text('Change'),
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
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
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
              // tombol button
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
                        onPressed: () async {
                          if (list == null) {
                            // tambah data
                            list = Product(
                                nameController.text,
                                int.parse(quantityController.text),
                                int.parse(priceController.text));
                          } else {
                            // ubah data
                            list.name = nameController.text;
                            list.quantity = int.parse(quantityController.text);
                            list.price = int.parse(priceController.text);
                            var result = await dbHelper.update(list);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, list);
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
