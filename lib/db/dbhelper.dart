// ignore: camel_case_types

import 'package:todo/entity/note.dart';

import '../appdatabase.dart';

// ignore: camel_case_types
class dbHelper {
  static AppDatabase? _database;
  static initDB() async {
    if (_database != null) return;
    _database =
        await $FloorAppDatabase.databaseBuilder('todo_database.db').build();
  }

  static Future<void> updateNote(note note) async{
    if (_database == null) return;
    await _database!.notesDao.updatetNote(note);

  } 
  static Future<void> updateNoteIsSync(bool isSync,int id) async {
    if (_database == null) return;
    await _database!.notesDao.updatetIsSyncbyId(isSync?1:0,id);
  }   
  static Future<void> deletNote(note note) async {
    if (_database == null) return;
    await _database!.notesDao.deleteNote(note);
  }  
  static Future<void> insertTonote(note note) async {
    if (_database == null) return;
    await _database!.notesDao.insertNote(note);
  }

  static Future<List<note>> getAllNoteForList() async {
    if (_database == null) return [];
    return await _database!.notesDao.getAllnotesforList();
  }
  static Future<List<note>> getAllNote() async {
    if (_database == null) return [];
    return await _database!.notesDao.getAllnotes();
  }
  static Future<void> updateNoteForDeleting(bool isDelete,int id) async {
    if (_database == null) return ;
    await _database!.notesDao.updatetIsDeletebyId(isDelete?1:0, id);
  }
}
