//pembuatan sebuah class Enrty yang nantinya akan digunakan pada fitur money entry
class Entry{
  //deklarasi masing-masing variabel
  int _entryId;
  String _title;
  int _total;

  //pembuatan getter setter

  int get entryId => _entryId;

  String get titlee => this._title;
  set titlee(String value) => this._title = value;

  get total => this._total;
  set total(value) => this._total = value;

  // konstruktor versi 1
  Entry(this._title, this._total);

  // konstruktor versi 2: konversi dari Map ke Item
  Entry.fromMap(Map<String, dynamic> map) {
    this._entryId = map['entryId'];
    this._title = map['titlee'];
    this._total = map['total'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['entryId'] = this._entryId;
    map['titlee'] = titlee;
    map['total'] = total;
    return map;
  }
}
