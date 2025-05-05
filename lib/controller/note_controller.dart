import 'package:flutter/material.dart';
import 'package:homie_app/controller/database_controller.dart';
import 'package:homie_app/model/note.dart';
import 'package:homie_app/model/note_category.dart';

class NoteController extends ChangeNotifier {
  final _notes = <Note>[];
  final _categories = <Category>[];

  List<Note> get notes => _notes;

  List<Category> get categories => _categories;

  void addNote(Note note, {bool saveToDB = false}) {
    _notes.add(note);
    notifyListeners();

    if (saveToDB) {
      var db = DatabaseController();
      db.addNote(note);
    }
  }

  void addCategory(Category category, {bool saveToDB = false}) {
    _categories.add(category);
    notifyListeners();

    if (saveToDB) {
      final db = DatabaseController();
      db.addCategory(category);
    }
  }

  Future<void> loadNotes() async {
    final db = DatabaseController();
    final map = await db.getNotes();
    for (final note in map['notes'] as List<Note>) {
      addNote(note);
    }

    for (final category in map['categories'] as List<Category>) {
      addCategory(category);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    final db = DatabaseController();
    await db.deleteCategory(categoryId);
    categories
        .remove(categories
        .where((element) => element.id == categoryId)
        .first);
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    final db = DatabaseController();
    db.updateCategory(category);

    var categoryIndex = categories.indexOf(categories
        .where((e) => e.id == category.id)
        .first);
    categories.replaceRange(categoryIndex, categoryIndex, [category]);
  }
}
