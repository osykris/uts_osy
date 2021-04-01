import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uts_osy/models/product.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'AdminStore.db';

    //create, read databases
    var db = openDatabase(path, version: 4, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return db;
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
 CREATE TABLE product (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT,
 quantity INTEGER,
 price INTEGER
 )
 ''');
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('product', orderBy: 'name');
    return mapList;
  }

//create databases
  Future<int> insert(Product object) async {
    Database db = await this.initDb();
    int count = await db.insert('product', object.toMap());
    return count;
  }

//update databases
  Future<int> update(Product object) async {
    Database db = await this.initDb();
    int count = await db.update('product', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('product', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Product>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Product> itemList = List<Product>();
    for (int i = 0; i < count; i++) {
      itemList.add(Product.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
