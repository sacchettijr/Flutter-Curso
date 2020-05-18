import 'dart:async';
import 'package:carros/utils/database/db_helper.dart';
import 'package:carros/utils/database/entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDAO<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get tableName;

  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(tableName, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    print('>>> ID: $id');
    return id;
  }

  Future<List<T>> query(String sql, [List<dynamic> arguments]) async {
    final dbClient = await db;
    final list = await dbClient.rawQuery(sql, arguments);
    return list.map<T>((json) => fromMap(json)).toList();
  }

  Future<List<T>> findAll() {
    return query('SELECT * FROM $tableName');
  }

  Future<T> findById(int id) async {
    List<T> list = await query('SELECT * FROM $tableName WHERE id = ?', [id]);

    return list.length > 0 ? list.first : null;
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('DELETE FROM carro');
  }
}
