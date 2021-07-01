import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBprovider extends ChangeNotifier {
  late Database db;
  late var todayinfo;

  Future<void> databaseinit() async {
    print(DateFormat('dd-MM-yyyy').format(DateTime.now()).toString());
    db = await initDB();
    todayinfo = await db.query('Client', where: '"date" = ?', whereArgs: [
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()
    ]);
    log('done');
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = (documentsDirectory.path + "DB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "date_time TEXT PRIMARY KEY,"
          "date TEXT,"
          "time TEXT,"
          "first_name TEXT,"
          "last_name TEXT,"
          "phone_no TEXT"
          ")");
    });
  }

  Future<void> addentry(date_time, first_name, last_name, phone_no) async {
    await db.insert(
        "Client",
        {
          'date_time': date_time,
          'date': date_time.toString().substring(0, 10),
          'time': date_time.toString().substring(
              date_time.toString().length - 2, date_time.toString().length),
          'first_name': first_name,
          'last_name': last_name,
          "phone_no": phone_no,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    log('done');
    notifyListeners();
  }

  Future<List> fetchentry(date_time) async {
    var maps = await db.query('Client');
    print(maps.asMap());
    var maps1 = await db.query('Client',
        // columns: ['date_time'],
        where: '"date_time" = ?',
        whereArgs: [date_time]);
    print(maps1.asMap());
    return maps1;
  }

  Future<List> fetchentrybydate(date) async {
    // var maps = await db.query('Client');
    // print(maps.asMap());
    var maps1 = await db.query('Client',
        // columns: ['date_time'],
        where: '"date" = ?',
        whereArgs: [date]);
    print(maps1.asMap());
    return maps1;
  }

  Future<void> deletedb(databasename) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = (documentsDirectory.path + databasename);
    await deleteDatabase(path);
    print('done');
  }

  Future<void> deleteentry(date_time) async {
    db.delete('Client', where: '"date_time" = ?', whereArgs: [date_time]);
  }
}
