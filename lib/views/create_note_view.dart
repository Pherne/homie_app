import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:homie_app/controller/note_controller.dart';
import 'package:homie_app/model/note_category.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:provider/provider.dart';

class CreateNoteView extends StatefulWidget {
  final bool? editNote;

  const CreateNoteView({super.key, this.editNote});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView>
    with SingleTickerProviderStateMixin {
  String? _selectedCategory;
  final _textEditingController = TextEditingController();
  var editNote = true;

  @override
  void initState() {
    if (widget.editNote != null) {
      setState(() {
        editNote = widget.editNote!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.clear), label: 'Zurück'),
          BottomNavigationBarItem(
              icon: Icon(Icons.save_alt), label: 'Speichern'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_note), label: 'Bearbeiten')
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
            case 1:
              Navigator.pop(context);
            case 2:
              setState(() {
                editNote = !editNote;
              });
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              editNote
                  ? TextFormField(
                      decoration: InputDecoration(
                        label: Text('Titel'),
                      ),
                    )
                  : Text(''),
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: DropdownButton(
                          items: [
                            for (final category
                                in context.watch<NoteController>().categories)
                              DropdownMenuItem(
                                  value: category.id,
                                  child: Text(category.title))
                          ],
                          value: _selectedCategory,
                          hint: Text('Kategorie wählen'),
                          onChanged: (element) =>
                              setState(() => _selectedCategory = element)),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                          onPressed: () => _openCreateCategoryDialog(
                              Provider.of<NoteController>(context,
                                  listen: false)),
                          icon: Icon(Icons.add)),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                          onPressed: () => _openCreateCategoryDialog(
                              Provider.of<NoteController>(context,
                                  listen: false)),
                          icon: Icon(Icons.edit_note)),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                          onPressed: _selectedCategory != null
                              ? () => _deleteCategory()
                              : null,
                          icon: Icon(Icons.delete)),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: editNote
                    ? TextFormField(
                        controller: _textEditingController,
                        onChanged: (text) =>
                            setState(() => _textEditingController.text = text),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        decoration: InputDecoration(
                          label: Text('Notiz'),
                        ),
                      )
                    : Html(
                        data: _textEditingController.text.isEmpty
                            ? 'Hier ist noch alles leer.'
                            : markdown
                                .markdownToHtml(_textEditingController.text)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCreateCategoryDialog(NoteController noteController,
      {bool edit = false}) {
    final dialogText = TextEditingController();
    var dialogKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text('Neue Kategorie erstellen'),
              // contentPadding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    key: dialogKey,
                    controller: dialogText,
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Bitte Namen angeben';
                      }

                      return null;
                    },
                    // onChanged: (text) => setState(() {
                    // }),
                    decoration: InputDecoration(label: Text('Name')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: dialogText.text.isNotEmpty?() {
                           if(edit) {

                           }
                              noteController.addCategory(
                                  Category(title: dialogText.text),
                                  saveToDB: true);
                              setState(() {
                                _selectedCategory =
                                    noteController.categories.last.id;
                              });
                              Navigator.pop(context);

                          }:null,
                          child: Text('Erstellen')),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Abbrechen'))
                    ],
                  ),
                )
              ],
            ));
  }

  void _deleteCategory() async {
    final selectedCategory = _selectedCategory;
    setState(() => _selectedCategory = null);
    Provider.of<NoteController>(context, listen: false)
        .deleteCategory(selectedCategory!);
  }

  void _editCategory() async {}
}
