import 'package:flutter/material.dart';
import 'package:matches/styles.dart';
import 'package:quickalert/models/quickalert_options.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_buttons.dart';

class AlertButton extends StatelessWidget {
  const AlertButton(
      {super.key, required this.buttonText, this.buttonColor, this.onTap});

  final String buttonText;
  final Color? buttonColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: QuickAlertButtons(
        options: QuickAlertOptions(
            type: QuickAlertType.info,
            cancelBtnText: "",
            confirmBtnText: buttonText,
            confirmBtnColor: buttonColor ?? warningSecondaryColor,
            showConfirmBtn: true,
            onConfirmBtnTap: onTap,
            showCancelBtn: false),
      ),
    );
  }
}
