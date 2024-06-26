import 'package:flutter/material.dart';
import 'package:matches/styles.dart';

class LoginInfoTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final List<String>? autofillHints;
  final Widget? suffixIcon;

  const LoginInfoTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.autofillHints,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        autofillHints: autofillHints,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
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
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
