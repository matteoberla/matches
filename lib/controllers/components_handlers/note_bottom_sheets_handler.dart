import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/styles.dart';

class NoteBottomSheetsHandler {
  showNoteBottomSheet(
      BuildContext context, String currentNote, Function(String) onSaveNote,
      {required bool readOnly}) async {
    bool saveNote = false;
    TextEditingController noteController =
        TextEditingController(text: currentNote);

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        double height = MediaQuery.of(context).size.height;
        return Container(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Scaffold(
                appBar: PalladioAppBar(
                  title: "Nota",
                  actions: [
                    Visibility(
                      visible: !readOnly,
                      child: IconButton(
                        icon: const Icon(
                          Icons.save,
                        ),
                        onPressed: () async {
                          saveNote = true;
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                body: PalladioBody(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            enabled: !readOnly,
                            controller: noteController,
                            decoration: InputDecoration(
                              hintText: "Note",
                              fillColor: backgroundColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: backgroundColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (saveNote) {
      onSaveNote(noteController.text);
    }
  }
}
