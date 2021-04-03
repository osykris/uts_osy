import 'package:flutter/material.dart';
import 'package:uts_osy/db_helper.dart';
import 'package:uts_osy/models/entry.dart';

class EntryInput extends StatefulWidget {
  final Entry entry;
  EntryInput(this.entry);
  @override
  EntryInputState createState() => EntryInputState(this.entry);
}

//class controller
class EntryInputState extends State<EntryInput> {
  DbHelper dbHelper = DbHelper();

  int count = 0;
  List<Entry> itemList;

  Entry entry;
  EntryInputState(this.entry);
  TextEditingController titleeController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  void initState() {
    super.initState();
    // get_option();
  }

  @override
  Widget build(BuildContext context) {
    //kondisi

    bool check = false;
    if (entry != null) {
      titleeController.text = entry.titlee.toString();
      totalController.text = entry.total.toString();
      check = true;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: entry == null
              ? Text('Add New Entry',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24))
              : Text('Edit Entry'),
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
              // harga
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  controller: titleeController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  controller: totalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Total',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 20.0),
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
                          if (entry == null) {
                            entry = Entry(titleeController.text,
                                int.parse(totalController.text));
                          }
                          // kembali ke layar sebelumnya dengan membawa objek pemsukkan
                          Navigator.pop(context, entry);
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
              if (check == true)
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            dbHelper.deleteEntry(entry.entryId);
                            Navigator.pop(context, entry);
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}
