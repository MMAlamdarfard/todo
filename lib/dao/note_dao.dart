

import 'package:floor/floor.dart';
import 'package:todo/entity/note.dart';

@dao
abstract class NoteDao {
  @Query('SELECT * FROM note WHERE isDelete=0')
  Future<List<note>> getAllnotesforList();

  @Query('SELECT * FROM note')
  Future<List<note>> getAllnotes();

  @Query('SELECT * FROM note WHERE id= :id')
  Future<note?> findNotebyid(int id);
  
  @Query('UPDATE note SET isSync = :isSync WHERE id = :id')
  Future<int?> updatetIsSyncbyId(int isSync, int id);

  @Query('UPDATE note SET isDelete = :isDelete WHERE id = :id')
  Future<int?> updatetIsDeletebyId(int isDelete, int id);
  
  @Query('DELETE FROM note')
  Future<void> deleteAllNote();
  
  @delete
  Future<void> deleteNote(note note);

  @insert
  Future<void> insertNote(note note);

  @update
  Future<void> updatetNote(note note);
  
  
 
}
