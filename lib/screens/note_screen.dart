import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/note_model.dart';
import 'package:flutter_sqflite/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;

  const NoteScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? "Add note" : "Edit note"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Note title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Note description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final title = titleController.value.text;
                    final desc = descriptionController.value.text;

                    debugPrint(title);
                    debugPrint(desc);

                    final Note model =
                        Note(title: title, desc: desc, id: note?.id);

                    if (note == null) {
                      await DatabaseHelper.addNote(model);
                    } else {
                      await DatabaseHelper.updateNote(model);
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Text(note == null ? "Save" : "Update"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
