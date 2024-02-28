import 'package:flutter/material.dart';

class SearchBarRowCallback {
  onKey(KeyEvent event, TextEditingController searchBarTextController,
      VoidCallback? onSearch) {
    if (event.logicalKey.keyLabel == "Enter") {
      if (onSearch != null) {
        onSearch();
      }
    } else {
      if (event.logicalKey.keyLabel == "Backspace") {
        if (searchBarTextController.text.isNotEmpty) {
          searchBarTextController.text = searchBarTextController.text
              .substring(0, searchBarTextController.text.length - 1);
        }
      } else {
        if (event.character != null) {
          searchBarTextController.text += event.character!;
        }
      }
    }
  }
}
