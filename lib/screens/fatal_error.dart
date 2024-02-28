import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_back_button.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';

class FatalErrorPage extends StatefulWidget {
  const FatalErrorPage(
      {required this.error, required this.stackTrace, super.key});

  final String error;
  final StackTrace stackTrace;

  @override
  State<FatalErrorPage> createState() => _FatalErrorPageState();
}

class _FatalErrorPageState extends State<FatalErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PalladioAppBar(
        title: "Errore Riscontrato",
        leading: PalladioBackButton(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/setup', (route) => false);
          },
        ),
      ),
      body: PalladioBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const PalladioText(
                  "Di seguito le informazioni sull'errore:",
                  type: PTextType.h2,
                  bold: true,
                ),
                const EmptySpace(
                  height: 10,
                ),
                PalladioText(
                  widget.error,
                  type: PTextType.h3,
                  bold: true,
                  maxLines: 100,
                ),
                const EmptySpace(
                  height: 10,
                ),
                PalladioText(
                  widget.stackTrace.toString(),
                  type: PTextType.h4,
                  maxLines: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
