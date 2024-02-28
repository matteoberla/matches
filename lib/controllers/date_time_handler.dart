import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:matches/styles.dart';

enum DateFormatType { date, time, dateAndTime, timeExtended, monthExtended }

class DateTimeHandler {
  static final firstAbsoluteDay =
      DateTime.now().add(const Duration(days: -10000));
  static final lastAbsoluteDay =
      DateTime.now().add(const Duration(days: 10000));

  static String? getElapsedTimeBetween(String? from, String? to) {
    DateTime? dateTimeFrom =
        getDateTimeFromString(from, DateFormatType.dateAndTime);
    DateTime? dateTimeTo =
        getDateTimeFromString(to, DateFormatType.dateAndTime);

    if (dateTimeFrom != null && dateTimeTo != null) {
      Duration timeBetween =
          calcElapsedTimeFromDateTimeToDateTime(dateTimeFrom, dateTimeTo);

      String hhmmDuration = printDuration(timeBetween);

      return getExtendedDuration(hhmmDuration, showSeconds: false);
    }

    return null;
  }

  static String getExtendedDuration(String? duration,
      {showSeconds = true, customReturnText = "Non calcolata"}) {
    if (duration == null) {
      return customReturnText;
    }

    List<String> parts = duration.split(":");

    int ore = int.parse(parts[0]);
    int minuti = int.parse(parts[1]);
    int secondi = int.parse(parts[2]);

    String oreFormatted = "";
    if (ore != 0) {
      oreFormatted = "$ore h ";
    }

    String minutiFormatted = "";
    if (minuti != 0) {
      minutiFormatted = "$minuti min ";
    }

    String secondiFormatted = "";
    if (showSeconds && secondi != 0) {
      secondiFormatted = "$secondi sec";
    }

    String formattedString = "$oreFormatted$minutiFormatted$secondiFormatted";
    if (formattedString == "") {
      //con stringa vuota
      formattedString = "0 min";
    }

    return formattedString;
  }

  static String getExtendedDate(String? dateToTransform) {
    if (dateToTransform != null) {
      DateTime? datetimeToTransform =
          getDateTimeFromString(dateToTransform, DateFormatType.date);

      if (datetimeToTransform != null) {
        return extendedDifference(datetimeToTransform);
      } else {
        return "Mai";
      }
    } else {
      return "Mai";
    }
  }

  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static Duration calcElapsedTime(DateTime initialTime) =>
      DateTime.now().difference(initialTime);

  static Duration calcElapsedTimeFromDateTimeToDateTime(
          DateTime initialTime, DateTime finalTime) =>
      finalTime.difference(initialTime);

  static Duration? calcElapsedTimeFromStringToString(String? from, String? to) {
    DateTime? initialTime =
        getDateTimeFromString(from, DateFormatType.dateAndTime);
    DateTime? finalTime = getDateTimeFromString(to, DateFormatType.dateAndTime);

    if (initialTime != null && finalTime != null) {
      return finalTime.difference(initialTime);
    }
    return null;
  }

  /// The [weekday] may be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  static mostRecentWeekday(DateTime date, int weekday) =>
      DateTime(date.year, date.month, date.day - (date.weekday - weekday) % 7);

  /// Returns the difference (in full days) between the provided date and today.
  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  static String extendedDifference(DateTime date) {
    int daysPassed = calculateDifference(date);
    if (daysPassed <= 0) {
      //giorni nel passato
      daysPassed *= -1;

      if (daysPassed == 0) {
        return "Oggi";
      }

      if (daysPassed == 1) {
        return "Ieri";
      }

      if (daysPassed <= 6) {
        return "$daysPassed gg. fa";
      }

      if (daysPassed <= 28) {
        int weeksPassed = daysPassed ~/ 7;
        return "$weeksPassed sett. fa";
      }
    } else {
      //giorni nel futuro

      if (daysPassed == 1) {
        return "Domani";
      }

      if (daysPassed <= 6) {
        return "Tra $daysPassed gg.";
      }

      if (daysPassed <= 28) {
        int weeksPassed = daysPassed ~/ 7;
        return "Tra $weeksPassed sett.";
      }
    }

    return getFormattedDateFromDateTime(date, DateFormatType.date);
  }

  ///

  static DateTime? getDateTimeFromString(
      String? dateTimeString, DateFormatType format) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString ?? "");
    return dateTime;
  }

  static String? getFormattedDateFromString(
      String? dateTimeString, DateFormatType format) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString ?? "");

    if (dateTime != null) {
      String formatString = "dd/MM/yyyy HH:mm";
      switch (format) {
        case DateFormatType.date:
          formatString = "dd/MM/yyyy";
          break;
        case DateFormatType.time:
          formatString = "HH:mm";
          break;
        case DateFormatType.timeExtended:
          formatString = "HH:mm:ss";
          break;
        case DateFormatType.monthExtended:
          formatString = "dd MMM yyyy";
        default:
          formatString = "dd/MM/yyyy HH:mm";
          break;
      }

      return DateFormat(formatString, "it_IT").format(dateTime);
    } else {
      return null;
    }
  }

  static String? getFormattedDateForAPI(
      String? dateTimeString, DateFormatType format) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString ?? "");
    if (dateTime != null) {
      String formatString = "yyyy-MM-dd HH:mm:ss";
      switch (format) {
        case DateFormatType.date:
          formatString = "yyyy-MM-dd";
          break;
        default:
          formatString = "yyyy-MM-dd HH:mm:ss";
          break;
      }
      return DateFormat(formatString).format(dateTime);
    }
    return null;
  }

  static String getFormattedDateFromDateTime(
      DateTime dateTime, DateFormatType format) {
    String formatString = "dd/MM/yyyy HH:mm";
    switch (format) {
      case DateFormatType.date:
        formatString = "dd/MM/yyyy";
        break;
      case DateFormatType.time:
        formatString = "HH:mm";
        break;
      case DateFormatType.timeExtended:
        formatString = "HH:mm:ss";
        break;
      default:
        formatString = "dd/MM/yyyy HH:mm";
        break;
    }

    return DateFormat(formatString).format(dateTime);
  }

  Future<DateTime?> showDateTimePickerBottomSheet(BuildContext context,
      DateTime? minDate, DateTime? initialTime, DateTime? maxDate,
      {DateTimePickerType type = DateTimePickerType.datetime,
      bool showDebugInfo = false,
      String? title,
      BoardPickerCustomOptions? customOptions}) async {
    if (showDebugInfo) {
      print("initial: $initialTime");
      print("min: $minDate");
      print("max: $maxDate");
    }

    DateTime? selectedDate = await showBoardDateTimePicker(
      context: context,
      pickerType: type,
      initialDate: initialTime,
      minimumDate: minDate,
      maximumDate: maxDate,
      options: BoardDateTimeOptions(
        languages: const BoardPickerLanguages.it(),
        startDayOfWeek: DateTime.monday,
        pickerFormat: PickerFormat.dmy,
        textColor: darkTextColor,
        activeColor: mainColor,
        activeTextColor: lightTextColor,
        customOptions: customOptions,
        boardTitle: title,
        showDateButton: false,
        pickerSubTitles: const BoardDateTimeItemTitles(
            year: "Anno",
            month: "Mese",
            day: "Giorno",
            hour: "Ora",
            minute: "Minuto"),
      ),
    );

    return selectedDate;
  }
}
