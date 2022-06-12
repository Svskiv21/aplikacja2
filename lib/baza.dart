import 'dart:async';
import 'package:aplikacja2/phone.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

class Baza {
  static Future<Database> openPhoneDatabase() async {
    return openDatabase(Path.join(await getDatabasesPath(), "phones"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE phones(id INTEGER PRIMARY KEY, producent TEXT, model TEXT, wersjaOprogramowania TEXT, photoUrl TEXT)');
    }, version: 1);
  }

  Future<void> insertPhone(Phone telefon) async {
    final db = await openPhoneDatabase();
    // final db = await phoneDatabase;

    await db.insert(
      'phones',
      telefon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GETTING A SINGLE RECORD BY ID
  // Future<Phone> getPhone(int id) async {
  //   final db = await openPhoneDatabase();
  //   await db.query('phones');
  //   return Phone(
  //     id: ,
  //     producent: ,
  //     model: ,
  //     wersjaOprogramowania: ,
  //     photoUrl: ,
  //   );
  //
  // }

  Future<List<Phone>> getPhones() async {
    final db = await openPhoneDatabase();
    // final db = await phoneDatabase;
    final List<Map<String, dynamic>> maps = await db.query('phones');
    return List.generate(maps.length, (i) {
      return Phone(
        id: maps[i]['id'],
        producent: maps[i]['producent'],
        model: maps[i]['model'],
        wersjaOprogramowania: maps[i]['wersjaOprogramowania'],
        photoUrl: maps[i]['photoUrl'],
      );
    });
  }

  Future<void> updatePhone(Phone phone) async {
    final db = await openPhoneDatabase();
    // final db = await phoneDatabase;
    await db.update(
      'phones',
      phone.toMap(),
      where: 'id = ?',
      whereArgs: [phone.id],
    );
  }

  Future<void> deletePhone(int id) async {
    final db = await openPhoneDatabase();
    // final db = await phoneDatabase;
    await db.delete(
      'phones',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLPhones() async {
    final db = await openPhoneDatabase();
    await db.execute('DELETE FROM phones');
  }
}
