// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _notesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `notes` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `category` INTEGER NOT NULL, `isSync` INTEGER NOT NULL, `isDelete` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get notesDao {
    return _notesDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'note',
            (note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'notes': item.notes,
                  'date': item.date,
                  'time': item.time,
                  'category': item.category,
                  'isSync': item.isSync,
                  'isDelete': item.isDelete
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'note',
            ['id'],
            (note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'notes': item.notes,
                  'date': item.date,
                  'time': item.time,
                  'category': item.category,
                  'isSync': item.isSync,
                  'isDelete': item.isDelete
                }),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'note',
            ['id'],
            (note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'notes': item.notes,
                  'date': item.date,
                  'time': item.time,
                  'category': item.category,
                  'isSync': item.isSync,
                  'isDelete': item.isDelete
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<note> _noteInsertionAdapter;

  final UpdateAdapter<note> _noteUpdateAdapter;

  final DeletionAdapter<note> _noteDeletionAdapter;

  @override
  Future<List<note>> getAllnotesforList() async {
    return _queryAdapter.queryList('SELECT * FROM note WHERE isDelete=0',
        mapper: (Map<String, Object?> row) => note(
            id: row['id'] as int?,
            title: row['title'] as String,
            notes: row['notes'] as String,
            category: row['category'] as int,
            date: row['date'] as String,
            time: row['time'] as String,
            isSync: row['isSync'] as int,
            isDelete: row['isDelete'] as int));
  }

  @override
  Future<List<note>> getAllnotes() async {
    return _queryAdapter.queryList('SELECT * FROM note',
        mapper: (Map<String, Object?> row) => note(
            id: row['id'] as int?,
            title: row['title'] as String,
            notes: row['notes'] as String,
            category: row['category'] as int,
            date: row['date'] as String,
            time: row['time'] as String,
            isSync: row['isSync'] as int,
            isDelete: row['isDelete'] as int));
  }

  @override
  Future<note?> findNotebyid(int id) async {
    return _queryAdapter.query('SELECT * FROM note WHERE id= ?1',
        mapper: (Map<String, Object?> row) => note(
            id: row['id'] as int?,
            title: row['title'] as String,
            notes: row['notes'] as String,
            category: row['category'] as int,
            date: row['date'] as String,
            time: row['time'] as String,
            isSync: row['isSync'] as int,
            isDelete: row['isDelete'] as int),
        arguments: [id]);
  }

  @override
  Future<int?> updatetIsSyncbyId(
    int isSync,
    int id,
  ) async {
    return _queryAdapter.query('UPDATE note SET isSync = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [isSync, id]);
  }

  @override
  Future<int?> updatetIsDeletebyId(
    int isDelete,
    int id,
  ) async {
    return _queryAdapter.query('UPDATE note SET isDelete = ?1 WHERE id = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [isDelete, id]);
  }

  @override
  Future<void> deleteAllNote() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }

  @override
  Future<void> insertNote(note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatetNote(note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(note note) async {
    await _noteDeletionAdapter.delete(note);
  }
}
