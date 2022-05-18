import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'CartModel.dart';

class DatabaseHelper {
  static final _databaseName = "Products.db";
  static final _databaseVersion = 1;

  static final table = 'product_table';

  static final columnId = '_id';
  static final columnVarient_id = 'varient_id';
  static final columnProductId = "product_id";
  static final columnImage = 'varient_image';
  static final columnUnit = 'unit';
  static final columnBaseMrp = "base_mrp";
  static final columnBasePrice = "base_price";
  static final columnProduct_varient_name = "product_varient_name";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnVarient_id TEXT NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnProductId TEXT NOT NULL,
            $columnUnit TEXT NOT NULL,
            $columnBaseMrp TEXT NOT NULL,
            $columnBasePrice TEXT NOT NULL,
            $columnProduct_varient_name TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<CartModel>> getProducts() async {
    var dbHelper = await instance.database;
    List<Map> maps = await dbHelper.query(table, columns: [
      columnBaseMrp,
      columnImage,
      columnProduct_varient_name,
      columnBasePrice,
      columnUnit,
      columnProductId,
      columnVarient_id
    ]);
    List<CartModel> product = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        product.add(CartModel.fromMap(maps[i]));
      }
    }
    return product;
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnVarient_id];
    return await db
        .update(table, row, where: '$columnVarient_id = ?', whereArgs: [id]);
  }
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '$columnVarient_id = ?', whereArgs: [id]);
  }
}
