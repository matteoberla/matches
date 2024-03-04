import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/team_components/team_flag_name.dart';
import 'package:matches/controllers/date_time_handler.dart';
import 'package:matches/controllers/fasi_handlers/fasi_handler.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_callback.dart';
import 'package:matches/controllers/matches_fin_handlers/matches_fin_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/fasi_models/fasi_model.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/fasi_provider/fasi_provider.dart';
import 'package:matches/state_management/matches_fin_provider/matches_fin_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class MatchFinTile extends StatelessWidget {
  MatchFinTile({super.key, required this.match, this.activeActions = true});

  final Matches match;
  final bool activeActions;

  final MatchesFinCallback matchesFinCallback = MatchesFinCallback();
  final MatchesFinHandler matchesFinHandler = MatchesFinHandler();
  final TeamsHandler teamsHandler = TeamsHandler();
  final FasiHandler fasiHandler = FasiHandler();

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: true);
    var matchesFinProvider =
        Provider.of<MatchesFinProvider>(context, listen: true);
    var fasiProvider = Provider.of<FasiProvider>(context, listen: true);

    MatchesBet? matchBet =
        matchesFinHandler.getMatchBetByMatchId(matchesFinProvider, match.id);

    Teams? team1 = teamsHandler.getTeamById(teamsProvider, matchBet?.idTeam1);
    Teams? team2 = teamsHandler.getTeamById(teamsProvider, matchBet?.idTeam2);

    Fasi? fase = fasiHandler.getFaseById(fasiProvider, match.fase);

    return GestureDetector(
      onTap: () async {
        if (activeActions) {
          await matchesFinCallback.onMatchTileTap(
              context, matchesFinProvider, match, matchBet);
        }
      },
      onLongPress: () async {
        if (activeActions) {
          await matchesFinCallback.onMatchTileLongPress(
              context, matchesFinProvider, match);
        }
      },
      child: Container(
        color: transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: matchesFinHandler.getTileColor(fase),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PalladioText(
                        fase?.fase ?? "???",
                        type: PTextType.h3,
                        textColor: opaqueTextColor,
                      ),
                      PalladioText(
                        " (Partita ${match.nMatch})",
                        type: PTextType.h3,
                        textColor: opaqueTextColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PalladioText(
                              match.des1 ?? "",
                              type: PTextType.h3,
                              textColor: opaqueTextColor,
                            ),
                            Row(
                              children: [
                                TeamFlagName(
                                  team: team1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            match.goalTeam1 == null && match.goalTeam2 == null,
                        child: Container(
                          decoration: const ShapeDecoration(
                            shape: StadiumBorder(),
                            color: interactiveColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2.0),
                            child: PalladioText(
                              "Ore ${DateTimeHandler.getFormattedDateFromString(match.date, DateFormatType.time) ?? "???"}",
                              type: PTextType.h3,
                              textColor: lightTextColor,
                              bold: true,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            match.goalTeam1 != null && match.goalTeam2 != null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2.0),
                          child: PalladioText(
                            "${match.goalTeam1} : ${match.goalTeam2}",
                            type: PTextType.h1,
                            bold: true,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PalladioText(
                              match.des2 ?? "",
                              type: PTextType.h3,
                              textColor: opaqueTextColor,
                            ),
                            Row(
                              children: [
                                TeamFlagName(
                                  team: team2,
                                  nameOnLeft: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: matchBet != null &&
                        matchBet.goalTeam1 != null &&
                        matchBet.goalTeam2 != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check,
                          color: successColor,
                        ),
                        PalladioText(
                          "Risultato (${team1?.name?.substring(0, 3).toUpperCase()} ${matchBet?.goalTeam1} : ${team2?.name?.substring(0, 3).toUpperCase()} ${matchBet?.goalTeam2})",
                          type: PTextType.h3,
                          textColor: opaqueTextColor,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: matchBet?.points != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.control_point_duplicate_sharp,
                          color: interactiveColor,
                        ),
                        const EmptySpace(
                          width: 5,
                        ),
                        PalladioText(
                          "Punti: ${matchBet?.points}",
                          type: PTextType.h3,
                          textColor: opaqueTextColor,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: matchBet == null ||
                        matchBet.goalTeam1 == null ||
                        matchBet.goalTeam2 == null,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          color: dangerColor,
                        ),
                        PalladioText(
                          "Risultato mancante",
                          type: PTextType.h3,
                          textColor: opaqueTextColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
