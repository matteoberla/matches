import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matches/styles.dart';

class RoundedTextField extends StatefulWidget {
  const RoundedTextField(
      {super.key,
      required this.label,
      required this.hintText,
      this.initialValue,
      this.controller,
      this.onChanged,
      this.onSearch,
      this.enabled = true,
      this.onClearPressed,
      required this.focusNode,
      required this.onKey,
      this.forcedKeyboardText = false,
      this.forcedKeyboardNone = false,
      this.autofocus = true});

  final String label;
  final String hintText;
  final String? initialValue;
  final Function(String newValue)? onChanged;
  final VoidCallback? onSearch;
  final TextEditingController? controller;
  final bool enabled;
  final VoidCallback? onClearPressed;
  final FocusNode focusNode;
  final Function(KeyEvent) onKey;
  final bool forcedKeyboardText;
  final bool forcedKeyboardNone;
  final bool autofocus;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool hasFocus = false;

  TextInputType keyboardType = TextInputType.none;

  @override
  void initState() {
    super.initState();
    if (widget.forcedKeyboardText || kIsWeb) {
      keyboardType = TextInputType.text;
    }
    if (widget.forcedKeyboardNone) {
      keyboardType = TextInputType.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (newFocusState) {
        setState(() {
          hasFocus = newFocusState;
        });
      },
      child: KeyboardListener(
        autofocus: false,
        focusNode:
            keyboardType == TextInputType.none ? widget.focusNode : FocusNode(),
        onKeyEvent: (event) {
          if ((event.logicalKey.keyLabel.length > 1 &&
                  event.logicalKey.keyLabel != "Enter" &&
                  event.logicalKey.keyLabel != "Backspace") ||
              event is KeyUpEvent) {
            return;
          }
          if (event is KeyDownEvent) {
            //eseguo solo se in modalità lettura barcode, altrimenti fa tutto il TextFormField dentro al RoundedTextField
            if (keyboardType == TextInputType.none) {
              widget.onKey(event);
            }
          }
        },
        child: TextFormField(
          autofocus: widget.autofocus,
          focusNode: keyboardType == TextInputType.text
              ? widget.focusNode
              : FocusNode(),
          textInputAction: TextInputAction.search,
          keyboardType: keyboardType,
          onFieldSubmitted: (value) {
            if (widget.onSearch != null && keyboardType == TextInputType.text) {
              widget.onSearch!();
            }
          },
          readOnly: keyboardType == TextInputType.none ? true : false,
          enabled: widget.enabled,
          showCursor: keyboardType == TextInputType.none ? false : true,
          initialValue: widget.initialValue,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            filled: true,
            fillColor: backgroundColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                  width: hasFocus ? 2.0 : 1.0,
                  color: hasFocus ? mainColor : opaqueColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                  width: hasFocus ? 2.0 : 1.0,
                  color: hasFocus ? mainColor : opaqueColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                  width: hasFocus ? 2.0 : 1.0,
                  color: hasFocus ? mainColor : opaqueColor),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(width: 2.0, color: errorColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(width: 2.0, color: errorColor),
            ),
            suffixIcon: IconButton(
              onPressed: widget.onClearPressed ?? () {},
              icon: const Icon(Icons.clear),
            ),
            prefixIcon: widget.forcedKeyboardText == false &&
                    widget.forcedKeyboardNone == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.forcedKeyboardText) {
                          return;
                        }
                        if (keyboardType == TextInputType.none) {
                          keyboardType = TextInputType.text;
                        } else {
                          keyboardType = TextInputType.none;
                        }
                      });
                      widget.focusNode.requestFocus();
                    },
                    icon: Icon(keyboardType == TextInputType.none
                        ? Icons.qr_code_scanner
                        : Icons.keyboard_alt_outlined),
                  )
                : null,
          ),
          onChanged: widget.onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci un valore';
            }
            return null;
          },
        ),
      ),
    );
  }
}
