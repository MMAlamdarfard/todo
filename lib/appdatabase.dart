
import 'dart:async';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
import 'entity/note.dart';
import 'dao/note_dao.dart';

part 'appdatabase.g.dart';



@Database(version: 1, entities: [note])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get notesDao;
}
