import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String contatoTable = "contatoTable";
final String idColumn = "idColumn";
final String nomeColumn = "nomeColumn";
final String emailColumn = "emailColumn";
final String telefoneColumn = "telefoneColumn";
final String imagemColumn = "imagemColumn";

class ContatoHelper {
  static final ContatoHelper _instance = ContatoHelper.internal();

  factory ContatoHelper() => _instance;

  ContatoHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $contatoTable("
          "$idColumn INTEGER PRIMARY KEY,"
          "$nomeColumn TEXT,"
          "$emailColumn TEXT,"
          "$telefoneColumn TEXT,"
          "$imagemColumn TEXT"
        ")"
      );
    });
  }

  Future<Contato> salvarContato (Contato contato) async {
    Database dbContato = await db;
    contato.id = await dbContato.insert(contatoTable, contato.toMap());
    return contato;
  }

  Future<Contato> getContato(int id) async {
    Database dbContato = await db;
    List<Map> maps = await dbContato.query(
      contatoTable,
      columns: [idColumn, nomeColumn, emailColumn, telefoneColumn, imagemColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );

    if (maps.length > 0) {
      return Contato.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContato(int id) async {
    Database dbContato = await db;
    return await dbContato.delete(
      contatoTable,
      where: "$idColumn = ?",
      whereArgs: [id]
    );
  }

  Future<int> atualizarContato(Contato contato) async {
    Database dbContato = await db;
    return await dbContato.update(
      contatoTable,
      contato.toMap(),
      where: "$idColumn = ?",
      whereArgs: [contato.id]
    );
  }

  Future<List> getTodosContatos() async {
    Database dbContato = await db;
    List listMap = await dbContato.rawQuery("SELECT * FROM $contatoTable");
    List<Contato> listaContato = List();
    for (Map m in listMap) {
      listaContato.add(
        Contato.fromMap(m)
      );
    }
    
    return listaContato;
  }

  Future<int> getNumber() async {
    Database dbContato = await db;
    return Sqflite.firstIntValue(
      await dbContato.rawQuery("SELECT COUNT(*) FROM $contatoTable")
    );
  }

  Future fechar() async {
    Database dbContato = await db;
    dbContato.close();
  }

}

class Contato {
  int id;
  String nome;
  String email;
  String telefone;
  String imagem;

  Contato();

  Contato.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    email = map[emailColumn];
    telefone = map[telefoneColumn];
    imagem = map[imagemColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeColumn: nome,
      emailColumn: email,
      telefoneColumn: telefone,
      imagemColumn: imagem,
    };

    if(id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contato(Id: $id, Nome: $nome, E-mail: $email, Telefone: $telefone, Imagem: $imagem)";
  }
}