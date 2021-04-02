import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:uts_osy/db_helper.dart';
import 'package:uts_osy/models/product.dart';
import 'package:uts_osy/pages/entry_product.dart';

//pendukung program asinkron
class List_Product extends StatefulWidget {
  @override
  List_ProductState createState() => List_ProductState();
}

class List_ProductState extends State<List_Product> {
  @override
  DbHelper dbHelper = DbHelper();
  int count = 0;
  int total_money = 0;
  List<Product> itemList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Product>();
    }
    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text('Puchase Planning',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
        ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var item = await navigateToEntryForm(context, null);
            if (item != null) {
              int result = await dbHelper.insertProduct(item);
              if (result > 0) {
                updateListView();
              }
            }
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }

  Future<Product> navigateToEntryForm(
      BuildContext context, Product item) async {
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
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
                title: Text(
                  this.itemList[index].name.toString(),
                  style: textStyle,
                ),
                subtitle: Text(this.itemList[index].quantity.toString() +
                    " /pcs" +
                    "\nRp. " +
                    this.itemList[index].price.toString() +
                    ",00"),
                onTap: () async {
                  var item =
                      await navigateToEntryForm(context, this.itemList[index]);

                  if (item != null) {
                    int result = await dbHelper.updateProduct(item);
                    if (result > 0) {
                      updateListView();
                    }
                  }
                },
                trailing: GestureDetector(
                    child: Icon(Icons.delete, color: Colors.red),
                    onTap: () async {
                      //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                      _showDeleteDialog(context, itemList[index].id);
                    })),
          );
        });
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  //Notofikasi telah terhapus di bawah sendiri nanti tampilannya
  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

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
                  child: Text("Cancel", style: TextStyle(color: Colors.white))),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    var result = await dbHelper.deleteProduct(itemId);
                    if (result > 0) {
                      Navigator.pop(context);
                      updateListView();
                      _showSuccessSnackBar(Text("Deleted",
                          style: TextStyle(color: Colors.white)));
                    }
                  },
                  child: Text("Delete")),
            ],
            title: Text("Are you sure you want to delete this?"),
          );
        });
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
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
