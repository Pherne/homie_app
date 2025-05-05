import 'package:uuid/uuid.dart';

import 'note_category.dart';

class Note {
  String? id;
  final String title;
  final String text;
  final Category category;

  Note(
      {this.id,required this.title, required this.text, required this.category});
}
