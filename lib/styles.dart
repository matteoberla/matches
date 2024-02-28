import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final canvasColor = Colors.grey[200];
const mainColor = Colors.blueGrey;
const backgroundColor = Colors.white;
const foregroundColor = Colors.black;
const iconsColor = Colors.black;
const iconsColorLight = Colors.white;
const cursorColor = Colors.black;
const transparent = Colors.transparent;
final dividerColor = Colors.grey[300]!;
final highlightColor = Colors.grey[300]!;
const selectedColor = Colors.grey;
final deactivatedColor = Colors.grey[300]!;
const opaqueColor = Colors.black12;
const stdBadgeColor = Colors.red;
const operationBadgeColor = Colors.lightBlueAccent;
//
const dangerColor = Colors.red;
const warningColor = Colors.yellow;
const warningSecondaryColor = Colors.orange;
const successColor = Colors.green;
const infoColor = Colors.lightBlue;
//
const errorColor = Colors.red;
const focusColor = Colors.blueAccent;
const correctColor = Colors.green;
const incompleteColor = Colors.yellow;
const interactiveColor = Colors.blue;
//
const bottomBannerColor = Colors.yellow;
//
const darkTextColor = Colors.black;
const lightTextColor = Colors.white;
const opaqueTextColor = Colors.grey;
final successOpaqueTextColor = Colors.green[50];
//
const timelineConnectorColor = Colors.grey;
final eventsDotColor = mainColor[300]!;
//
const notificationColor = Colors.orange;
final receivedBubbleColor = Colors.grey[300]!;
final sentBubbleColor = Colors.green[300]!;

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.grey,
      primaryColor: backgroundColor,
      indicatorColor: const Color(0xffCBDCF8),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xffF1F5FB),
      ),
      hintColor: const Color(0xffEECED3),
      highlightColor: highlightColor,
      hoverColor: transparent,
      focusColor: transparent,
      disabledColor: Colors.grey,
      iconTheme: const IconThemeData(color: iconsColor),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: cursorColor),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      cardColor: backgroundColor,
      canvasColor: canvasColor,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: const ColorScheme.light(),
          ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        iconTheme: IconThemeData(color: iconsColor),
      ),
    );
  }
}
