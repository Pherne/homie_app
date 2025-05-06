import 'package:flutter/material.dart';
import 'package:homie_app/views/view_util.dart';

class MarkDownTextField extends StatefulWidget {
  final TextEditingController controller;

  const MarkDownTextField({super.key, required this.controller});

  @override
  State<MarkDownTextField> createState() => _MarkDownTextFieldState();
}

class _MarkDownTextFieldState extends State<MarkDownTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => _handleSelection(MarkDownType.bold),
              icon: Icon(Icons.format_bold),
            ),
            IconButton(
              onPressed: () => _handleSelection(MarkDownType.italic),
              icon: Icon(Icons.format_italic),
            ),
            IconButton(
              onPressed: () => _handleSelection(MarkDownType.blockquote),
              icon: Icon(Icons.format_quote),
            ),
            PopupMenuButton<MarkDownType>(
              icon: Icon(Icons.title),
              itemBuilder: (context) => [
                PopupMenuItem<MarkDownType>(
                  value: MarkDownType.heading1,
                  onTap: () => _handleSelection(MarkDownType.heading1),
                  child: Text('1'),
                ),
                PopupMenuItem<MarkDownType>(
                  value: MarkDownType.heading2,
                  onTap: () => _handleSelection(MarkDownType.heading2),
                  child: Text('2'),
                ),
                PopupMenuItem<MarkDownType>(
                  value: MarkDownType.heading3,
                  onTap: () => _handleSelection(MarkDownType.heading3),
                  child: Text('3'),
                ),
              ],
            ),
            IconButton(
              onPressed: () => _handleSelection(MarkDownType.link),
              icon: Icon(Icons.link),
            ),
            IconButton(
              onPressed: () => _handleSelection(MarkDownType.checkList),
              icon: Icon(Icons.check_box),
            ),
          ],
        ),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            label: Text('Notiz'),
          ),
        )
      ],
    );
  }

  void _handleSelection(MarkDownType type) {
    if (controller.selection.isValid) {
      var selectedText = controller.text
          .substring(controller.selection.start, controller.selection.end);

      controller.text = controller.text.replaceRange(controller.selection.start,
          controller.selection.end, _addMarkDownComponent(type, selectedText));
    } else {
      controller.text += _addMarkDownComponent(type);
    }
  }

  String _addMarkDownComponent(MarkDownType type, [String? text]) {
    switch (type) {
      case MarkDownType.bold:
        return '**${text ?? ''}**';
      case MarkDownType.italic:
        return '*${text ?? ''}*';
      case MarkDownType.blockquote:
        return '> ${text ?? ''}';
      case MarkDownType.orderedList:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MarkDownType.unorderedList:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MarkDownType.checkList:
        return '- [ ] ${text ?? ''}';
      case MarkDownType.link:
        return '[${text ?? ''}]()';
      case MarkDownType.image:
        // TODO: Handle this case.
        throw UnimplementedError();
      case MarkDownType.heading1:
        return '# ${text ?? ''}';
      case MarkDownType.heading2:
        return '## ${text ?? ''}';
      case MarkDownType.heading3:
        return '### ${text ?? ''}';
    }
  }
}
