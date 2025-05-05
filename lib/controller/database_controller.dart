import 'package:homie_app/model/note.dart';
import 'package:homie_app/model/note_category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

/// controller for the database
/// uses [sqflite]
class DatabaseController {
  late String _dbPath;
  late Database _database;

  /// opens the database
  /// on initial opening the database is created
  Future<void> _openDB() async {
    _dbPath = await getDatabasesPath();
    _database = await openDatabase('$_dbPath/homie.db', version: 1,
        onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON");
    }, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE Category (id TEXT PRIMARY KEY NOT NULL, title TEXT)');
      await db.execute(
          'CREATE TABLE Note (id TEXT PRIMARY KEY NOT NULL, title TEXT, category_id TEXT NOT NULL, text TEXT, FOREIGN KEY(category_id) REFERENCES Category(id))');
    });
  }

  /// closes the database
  Future<void> _closeDB() async {
    await _database.close();
  }

  /// creates an id for the category and adds it to the database
  void addCategory(Category category) async {
    await _openDB();
    await _database.transaction((action) async {
      final id = (Uuid().v1()).replaceAll('-', '');
      await action.rawInsert('INSERT INTO Category(id, title) VALUES(?,?)',
          ['C$id', category.title]);
    });
    _closeDB();
  }

  /// create an id for the note and adds it to the database
  void addNote(Note note) async {
    await _openDB();
    await _database.transaction((action) async {
      final id = (Uuid().v1()).replaceAll('-', '');
      await action.rawInsert(
          'INSERT INTO Note(id, title, category_id, text) VALUES(?,?,?)',
          ['N$id', note.title, note.category.id, note.text]);
    });
    _closeDB();
  }

  /// updates the title of a category in a database
  void updateCategory(Category category) async {
    await _openDB();
    await _database.rawUpdate(
        'UPDATE Category SET title, WHERE id=${category.id}', [category.title]);
    await _closeDB();
  }

  /// updates title, category id and text of a nate in the database
  void updateNote(Note note) async {
    await _openDB();
    await _database.rawUpdate(
        'UPDATE Note SET title, category_id, text WHERE id=${note.id}',
        [note.title, note.category.id, note.text]);
    await _closeDB();
  }

  /// returns all the categories in the database
  /// can only be called inside [DatabaseController]
  Future<List<Category>> _getCategories() async {
    var categoryMap = await _database.rawQuery('SELECT * FROM Category');
    var categories = <Category>[];

    for (final category in categoryMap) {
      if (!category.containsValue(null)) {
        categories.add(Category(
            id: category['id'].toString(),
            title: category['title'].toString()));
      }
    }
    return categories;
  }

  /// returns all the notes in the database and calls [_getCategories] to add
  /// the corresponding categories to the notes
  Future<Map<String, Object>> getNotes() async {
    await _openDB();
    var noteMap = await _database.rawQuery('SELECT * FROM Note');
    var notes = <Note>[];
    var categories = await _getCategories();

    for (final note in noteMap) {
      if (!note.containsValue(null)) {
        notes.add(Note(
            id: note['id'].toString(),
            title: note['title'].toString(),
            text: note['text'].toString(),
            category: categories
                .where(
                    (element) => element.id == note['category_id'].toString())
                .first));
      }
    }
    _closeDB();
    return {'notes': notes, 'categories': categories};
  }

  /// deletes all categories
  Future<void> deleteAllCategories() async {
    await _openDB();
    await _database.delete('Category');
    await _closeDB();
  }

  /// deletes all Notes
  Future<void> deleteAllNotes() async {
    await _openDB();
    await _database.delete('Note');
    await _closeDB();
  }

  /// deletes a specific category using its id
  Future<void> deleteCategory(String category) async {
    await _openDB();
    await _database
        .rawDelete('DELETE FROM Category WHERE id = ?', [category]);
    await _closeDB();
  }
}
