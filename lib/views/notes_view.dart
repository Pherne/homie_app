import 'package:flutter/material.dart';
import 'package:homie_app/controller/database_controller.dart';
import 'package:homie_app/controller/note_controller.dart';
import 'package:homie_app/model/note.dart';
import 'package:homie_app/views/create_note_view.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<StatefulWidget> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {

  @override
  void initState() {
    Provider.of<NoteController>(context, listen: false).loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var noteController = context.watch<NoteController>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Neue Notiz'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Suchen')
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            _createNote();
          case 1:
        //     TODO: Suche implement search
var db=DatabaseController();
db.deleteAllCategories();
        }
      },
      ),
      body: noteController.notes.isEmpty
          ? Center(child: Text('Füge Notizen hinzu!'))
          : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              children: [
                for (final note in context.watch<NoteController>().notes)
                  _createCard(note)
              ],
            ),
    );
  }

  _createCard(Note note) {
    return Card(
      child: Column(
        children: [Text(note.title), Text(note.text)],
      ),
    );
  }

  _createNote() {
    var noteController = Provider.of<NoteController>(context, listen: false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: noteController,
          child: CreateNoteView(),
        ),
      ),
    );
  }
}
