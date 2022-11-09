import 'dart:io';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sti_rpl_todo/models/kategori.model.dart';

class DatabaseInterface {
  Future insertKategori(KategoriModel kategori) async {}
  Future<List<KategoriModel>> getKategories() async {
    throw UnimplementedError();
  }
}

class DatabaseService implements DatabaseInterface {
  var databaseFactory = databaseFactoryFfi;
  static DatabaseService shared = DatabaseService();
  late Database db;

  Future onCreate() async {
    db = await initDB();
  }

  Future<Database> initDB() async {
    if (Platform.isWindows) {
      sqfliteFfiInit();
    }
    var path = await databaseFactory.getDatabasesPath();
    var db = await databaseFactory.openDatabase(join(path, 'database.db'),
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              await db.execute(
                  'CREATE TABLE Kategori (id INTEGER PRIMARY KEY, name TEXT, colorCode INTEGER)');
            }));
    return db;
  }

  @override
  Future insertKategori(KategoriModel kategori) async {
    await db.rawInsert("INSERT INTO Kategori(name, colorCode) VALUES(?,?);",
        kategori.toArguments());
    await getKategories();
  }

  @override
  Future<List<KategoriModel>> getKategories() async {
    var result = await db.rawQuery("SELECT * FROM Kategori");
    List<KategoriModel> kategoriList = [];
    result.forEach((e) {
      kategoriList.add(KategoriModel.fromMap(e));
    });
    return kategoriList;
  }
}
