import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matches/styles.dart';

enum AllowedChars { text, integer, double }

class PalladioTextInput extends StatelessWidget {
  const PalladioTextInput(
      {super.key,
      required this.textController,
      this.focusNode,
      this.onTap,
      this.onChanged,
      this.focused,
      this.error,
      this.textAlign = TextAlign.end,
      this.forcedKeyboard = true,
      this.keyboardType = TextInputType.text,
      this.onFocusChanged,
      required this.allowedChars,
      this.readOnly = false,
      this.enabled = true});

  final TextEditingController textController;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Function(String newText)? onChanged;
  final bool? focused;
  final bool? error;
  final TextAlign textAlign;
  final bool forcedKeyboard;
  final TextInputType? keyboardType;
  final VoidCallback? onFocusChanged;
  final AllowedChars allowedChars;
  final bool readOnly;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (onFocusChanged != null && hasFocus == false) {
          onFocusChanged!();
        }
      },
      child: TextField(
        showCursor: kIsWeb ? true : forcedKeyboard,
        keyboardType: forcedKeyboard ? keyboardType : TextInputType.none,
        inputFormatters: <TextInputFormatter>[
          if (allowedChars == AllowedChars.double)
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,10}')),
          if (allowedChars == AllowedChars.integer)
            FilteringTextInputFormatter.digitsOnly,
        ],
        // Only numbers can be entered
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: backgroundColor,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        maxLines: null,
        controller: textController,
        focusNode: focusNode,
        onTap: onTap,
        onChanged: onChanged,
        textAlign: textAlign,
        readOnly: readOnly,
        enabled: enabled,
      ),
    );
  }

  Color getBorderColor(bool? error, bool? focused) {
    if (error == true) {
      return errorColor;
    }
    if (focused == true) {
      return focusColor;
    } else {
      return mainColor;
    }
  }

  double getWidth(bool? error, bool? focused) {
    if (error == true) {
      return 2.0;
    }
    if (focused == true) {
      return 1.5;
    } else {
      return 1.0;
    }
  }
}
