import 'package:flutter/cupertino.dart';

class TextControllerHandler {
  static moveCursorToEnd(TextEditingController? textController) {
    if (textController == null) return;

    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
  }
}
