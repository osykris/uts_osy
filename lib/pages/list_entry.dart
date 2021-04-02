import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:uts_osy/db_helper.dart';
import 'package:uts_osy/models/entry.dart';
import 'package:uts_osy/pages/entry_entry.dart';

//pendukung program asinkron
class EntryEntry extends StatefulWidget {
  @override
  EntryEntryState createState() => EntryEntryState();
}

class EntryEntryState extends State<EntryEntry> {
  @override
  DbHelper dbHelper = DbHelper();
  int count = 0;
  int total_money = 0;
  List<Entry> itemList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Entry>();
    }
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          'Money Entry',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            child: Image.asset('assets/images/money.jpg'),
          ),
        ),
        Expanded(
          child: createListView(),
        ),
        Container(
          height: 70,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Text("Total : Rp. $total_money,00",
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            int result = await dbHelper.insertEntry(item);
            setState(() {
              this.total_money += item.total;
            });
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
      ),
    );
  }

  Future<Entry> navigateToEntryForm(BuildContext context, Entry item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryInput(item);
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
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Rp." + this.itemList[index].total.toString() + ",00",
              style: textStyle,
            ),
            subtitle: Text(this.itemList[index].titlee.toString()),
            onTap: () async {},
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.red),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                _showDeleteDialog(context, itemList[index].entryId);
              },
            ),
          ),
        );
      },
    );
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
                    var result = await dbHelper.deleteEntry(itemId);
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
      Future<List<Entry>> itemListFuture = dbHelper.getEntryList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
