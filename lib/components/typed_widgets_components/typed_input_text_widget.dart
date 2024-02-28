import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text_input.dart';

class TypedTextInputWidget extends StatelessWidget {
  const TypedTextInputWidget(
      {super.key,
      required this.textController,
      this.onTap,
      this.onChanged,
      this.onFocusChanged,
      this.focused,
      this.forcedTextKeyboard = true,
      this.keyboardType = TextInputType.text,
      required this.allowedChars,
      this.readOnly = false,
      this.enabled = true,
      this.textAlign = TextAlign.end});

  final TextEditingController textController;
  final VoidCallback? onTap;
  final Function(String newText)? onChanged;
  final VoidCallback? onFocusChanged;
  final bool? focused;
  final bool forcedTextKeyboard;
  final TextInputType keyboardType;
  final AllowedChars allowedChars;
  final bool readOnly;
  final bool enabled;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return PalladioTextInput(
      textController: textController,
      onTap: onTap,
      onChanged: onChanged,
      onFocusChanged: onFocusChanged,
      focused: focused,
      forcedKeyboard: forcedTextKeyboard,
      keyboardType: keyboardType,
      allowedChars: allowedChars,
      readOnly: readOnly,
      enabled: enabled,
      textAlign: textAlign,
    );
  }
}
