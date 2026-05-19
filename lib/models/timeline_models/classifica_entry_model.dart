import 'package:flutter/material.dart';

class ClassificaEntry {
  final int pos;
  final String nome;
  final Color color;
  final IconData? icon;

  const ClassificaEntry(
      {required this.pos, required this.nome, required this.color, this.icon});
}
