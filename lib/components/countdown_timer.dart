import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/models/login_models/login_model.dart';
import 'package:matches/styles.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({super.key});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  LoginHandler loginHandler = LoginHandler();
  LoginModel? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = loginHandler.getCurrentUser(context);
    _update();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _update());
  }

  void _update() {
    final now = DateTime.now();
    if (mounted) {
      setState(() {
        _remaining = (DateTimeHandler.getDateTimeFromString(
                    currentUser?.dtScadenza ?? "",
                    DateFormatType.dateAndTime) ??
                DateTime(1970))
            .difference(now);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overdue = DateTime.now().difference(
      DateTimeHandler.getDateTimeFromString(
              currentUser?.dtScadenza ?? "", DateFormatType.dateAndTime) ??
          DateTime(1970),
    );

    // Nasconde il widget dopo 24h dalla scadenza
    if (overdue.inHours >= 24) {
      return const SizedBox.shrink();
    }

    // Scadenza superata
    if (_remaining.isNegative) {
      return _OverdueMessage();
    }

    // Countdown attivo
    return _CountdownDisplay(remaining: _remaining);
  }
}

// Widget countdown attivo
class _CountdownDisplay extends StatelessWidget {
  final Duration remaining;

  const _CountdownDisplay({required this.remaining});

  String _pad(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = _pad(remaining.inHours % 24);
    final minutes = _pad(remaining.inMinutes % 60);
    final seconds = _pad(remaining.inSeconds % 60);

    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PalladioText(
            "Compila entro",
            type: PTextType.h5,
          ),
          const EmptySpace(
            height: 2,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4,
            children: [
              if (days > 0) ...[
                _TimeUnit(value: '$days', label: 'gg'),
              ],
              _TimeUnit(value: hours, label: 'h'),
              _TimeUnit(value: minutes, label: 'm'),
              _TimeUnit(value: seconds, label: 's'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final String value;
  final String label;

  const _TimeUnit({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PalladioText(
              value,
              type: PTextType.h2,
              bold: true,
            ),
            const EmptySpace(
              width: 1,
            ),
            PalladioText(
              label,
              type: PTextType.h5,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget scadenza superata
class _OverdueMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_clock_outlined,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 10),
          Text(
            'Fase di compilazione terminata!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
