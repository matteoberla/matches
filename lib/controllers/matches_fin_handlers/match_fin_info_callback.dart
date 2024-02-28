import 'package:flutter/material.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/match_fin_info_handler.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';

class MatchFinInfoCallback {
  onDataPressed(BuildContext context, MatchesFinProvider provider) async {
    DateTimeHandler dateTimeHandler = DateTimeHandler();
    DateTime? selectedDate =
        await dateTimeHandler.showDateTimePickerBottomSheet(
      context,
      null,
      DateTime.tryParse(provider.selectedMatch?.date ?? ""),
      null,
    );

    String? formattedSelectedDate = DateTimeHandler.getFormattedDateForAPI(
        selectedDate.toString(), DateFormatType.dateAndTime);

    if (formattedSelectedDate != null) {
      provider.updateDataOfSelectedMatch(formattedSelectedDate);
    }
  }

  onFasePressed(BuildContext context, MatchesFinProvider provider) async {
    MatchFinInfoHandler matchFinInfoHandler = MatchFinInfoHandler();
    await matchFinInfoHandler.editFase(context, provider);
  }

  onSaveMatch(BuildContext context, MatchesFinProvider provider) async {
    MatchFinInfoHandler matchFinInfoHandler = MatchFinInfoHandler();
    await matchFinInfoHandler.verifyMatch(context, provider);
  }
}
