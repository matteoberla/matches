import 'package:flutter/material.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/matches_handlers/match_info_handler.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';

class MatchInfoCallback {
  onDataPressed(BuildContext context, MatchesProvider provider) async {
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

  onFasePressed(BuildContext context, MatchesProvider provider) async {
    MatchInfoHandler matchInfoHandler = MatchInfoHandler();
    await matchInfoHandler.editFase(context, provider);
  }

  onTeam1Pressed(BuildContext context, MatchesProvider provider) async {
    MatchInfoHandler matchInfoHandler = MatchInfoHandler();
    await matchInfoHandler.editTeam1(context, provider);
  }

  onTeam2Pressed(BuildContext context, MatchesProvider provider) async {
    MatchInfoHandler matchInfoHandler = MatchInfoHandler();
    await matchInfoHandler.editTeam2(context, provider);
  }

  onSaveMatch(BuildContext context, MatchesProvider provider) async {
    MatchInfoHandler matchInfoHandler = MatchInfoHandler();
    await matchInfoHandler.verifyMatch(context, provider);
  }
}
