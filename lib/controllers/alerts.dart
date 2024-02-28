import 'package:flutter/material.dart';
import 'package:matches/components/alerts_components/alert_button.dart';
import 'package:matches/main.dart';
import 'package:matches/styles.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Alerts {
  static var screenWidth =
      MediaQuery.of(navigatorKey.currentState!.context).size.width;
  static const maxWidth = 550.0;

  static showSuccessAlertNoContext(String? title, String text) async {
    await QuickAlert.show(
        customAsset: 'assets/quickalert/success.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.success,
        title: title ?? 'Conferma',
        text: text,
        confirmBtnText: 'Ok',
        cancelBtnText: 'Ok',
        width: screenWidth > maxWidth ? maxWidth : null);
  }

  static showErrorAlertNoContext(String? title, String text) async {
    await QuickAlert.show(
        customAsset: 'assets/quickalert/error.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.error,
        title: title ?? 'Errore',
        text: text,
        confirmBtnText: 'Ok',
        cancelBtnText: 'Ok',
        width: screenWidth > maxWidth ? maxWidth : null);
  }

  static showWarningAlertNoContext(String? title, String text) async {
    await QuickAlert.show(
        customAsset: 'assets/quickalert/warning.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.warning,
        title: title ?? 'Attenzione',
        text: text,
        confirmBtnText: "Ok",
        width: screenWidth > maxWidth ? maxWidth : null);
  }

  static showInfoAlertNoContext(String? title, String text) async {
    await QuickAlert.show(
        customAsset: 'assets/quickalert/info.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.info,
        title: title ?? 'Informazione',
        text: text,
        confirmBtnText: "Ok",
        width: screenWidth > maxWidth ? maxWidth : null);
  }

  static showConfirmAlertNoContext(String? title, String text,
      VoidCallback onConfirm, VoidCallback onCancel) async {
    await QuickAlert.show(
        customAsset: 'assets/quickalert/confirm.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.confirm,
        title: title ?? 'Confermare?',
        text: text,
        confirmBtnText: 'Si',
        cancelBtnText: '   Annulla   ',
        onConfirmBtnTap: onConfirm,
        onCancelBtnTap: onCancel,
        confirmBtnColor: successColor,
        width: screenWidth > maxWidth ? maxWidth : null);
  }

  static showFatalErrorAlertNoContext(String? title, String text,
      VoidCallback onConfirm, VoidCallback onCancel) async {
    await QuickAlert.show(
        customAsset: 'assets/quickalert/warning.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.confirm,
        title: title ?? 'Errore',
        text: text,
        confirmBtnText: 'Mostra Errore',
        cancelBtnText: '  Esci  ',
        onConfirmBtnTap: onConfirm,
        onCancelBtnTap: onCancel,
        confirmBtnColor: warningSecondaryColor,
        width: screenWidth > maxWidth ? maxWidth : null);
  }

  static showCustomAlertNoContext(
      String? title,
      String? text,
      List<AlertButton> buttonsList,
      Widget? customText,
      String? confirmButtonText,
      VoidCallback? onCancel) async {
    double height =
        MediaQuery.of(navigatorKey.currentState!.context).size.height;
    await QuickAlert.show(
        customAsset: 'assets/quickalert/info.gif',
        context: navigatorKey.currentState!.context,
        type: QuickAlertType.custom,
        title: title ?? 'Errore',
        text: text,
        confirmBtnText: confirmButtonText ?? '   Annulla   ',
        onConfirmBtnTap: onCancel,
        widget: Container(
          constraints: BoxConstraints(maxHeight: 0.4 * height),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (customText != null) customText,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttonsList,
                ),
              ],
            ),
          ),
        ),
        width: screenWidth > maxWidth ? maxWidth : null);
  }
}
