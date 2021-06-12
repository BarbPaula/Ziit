import "dart:io" as io;
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import '../data/UfClass.dart';

class SqliteDB {
  static final SqliteDB _instance = new SqliteDB.internal();

  factory SqliteDB() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SqliteDB.internal();

  /// Initialize DB
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "myDatabase.db");
    var taskDb =
        await openDatabase(path, version: 1);
    return taskDb;
  }

  /// Count number of tables in DB
  Future countTable() async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
         WHERE type = 'table' 
         AND name != 'android_metadata' 
         AND name != 'sqlite_sequence';""");
    return res[0]['count'];
  }
}

Future criaTabela() async{

   WidgetsFlutterBinding.ensureInitialized();

    // Referencia para o banco
    final db = await SqliteDB().db;

    var res0 = await db.execute("DROP TABLE IF EXISTS f00_usuario;");
     var res3 = await db.execute("DROP TABLE IF EXISTS t00_01_Estados_IBGE;");

    var res = await db.execute("""
      CREATE TABLE f00_usuario(
        f00_id,
        f00_nome TEXT,
        f00_email TEXT,
        f00_senha TEXT
      )""");

     var res5 = await db.execute("""
      CREATE TABLE  t00_01_Estados_IBGE(
        cod TEXT,
        sigla TEXT
      )""");


}

insereEstado(estado novoEstado) async{
   final db = await SqliteDB().db;

    var res0 = await db.insert('t00_01_Estados_IBGE', novoEstado.toJson()); 
}


Future <List<estado>> listaEstado() async{
  
  final db = await SqliteDB().db;

  var res0 = await db.rawQuery("Select * from t00_01_Estados_IBGE");

  List<estado> list = res0.isNotEmpty? res0.map((e) => estado.fromJson(e)).toList():[];

  return list;
}
