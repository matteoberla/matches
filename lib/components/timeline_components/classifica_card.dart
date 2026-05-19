import 'package:flutter/material.dart';
import 'package:matches/models/timeline_models/classifica_entry_model.dart';

class ClassificaCard extends StatelessWidget {
  final List<ClassificaEntry> entries;
  final String title;

  const ClassificaCard({super.key, required this.entries, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...entries.map((entry) => _ClassificaRow(entry: entry)),
          ],
        ),
      ),
    );
  }
}

class _ClassificaRow extends StatelessWidget {
  final ClassificaEntry entry;

  const _ClassificaRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.emoji_events, color: entry.color, size: 26),
          const SizedBox(width: 8),
          Text(
            '${entry.pos}°',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: entry.color,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          Text(entry.nome, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
