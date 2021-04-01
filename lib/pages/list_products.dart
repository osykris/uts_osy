import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_osy/db_helper.dart';
import 'dart:async';

import 'package:uts_osy/models/product.dart';
import 'package:uts_osy/pages/entry_product.dart';

//pendukung program asinkron
class List_Product extends StatefulWidget {
  @override
  List_ProductState createState() => List_ProductState();
}

class List_ProductState extends State<List_Product> {
  Product item;
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Product> itemList;

  // Metode untuk menampilkan dialog konfirmasi penghapusan event
  _showDeleteDialog(BuildContext context, itemId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.green,
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    var result = await dbHelper.delete(itemId);
                    if (result > 0) {
                      Navigator.pop(context);
                      updateListView();
                      _showSuccessSnackBar(Text("Deleted"));
                    }
                  },
                  child: Text("Delete")),
            ],
            title: Text("Are you sure you want to delete this?"),
          );
        });
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  //Notofikasi telah terhapus di bawah sendiri nanti tampilannya
  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Product>();
    }
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          'Purchase Plan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var item = await navigateToEntryForm(context, null);
            if (item != null) {
              //TODO 2 Panggil Fungsi untuk Insert ke DB
              int result = await dbHelper.insert(item);
              if (result > 0) {
                updateListView();
              }
            }
          },
          tooltip: 'Increment',
          child: Icon(Icons.add, color: Colors.white)),
      body: Column(children: [
        Expanded(
          child: Container(
            child: Image.asset('assets/images/Shoppingfun.jpg'),
          ),
        ),
        Expanded(
          child: createListView(),
        ),
      ]),
    );
  }

  Future<Product> navigateToEntryForm(
      BuildContext context, Product list) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return Entry_Product(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.cyan,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemList[index].name,
              style: textStyle,
            ),
            subtitle: Text("Price       : Rp. " +
                this.itemList[index].price.toString() +
                " \nQuantity : " +
                this.itemList[index].quantity.toString()),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                _showDeleteDialog(context, itemList[index].id);
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              updateListView();
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Product>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
