import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/team_components/team_flag_name.dart';
import 'package:matches/controllers/fasi_handlers/fasi_handler.dart';
import 'package:matches/controllers/matches_handlers/matches_callback.dart';
import 'package:matches/controllers/matches_handlers/matches_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/matches_models/matches_bet_model.dart';
import 'package:matches/models/matches_models/matches_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/matches_provider/matches_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class MatchTile extends StatelessWidget {
  MatchTile({super.key, required this.match, this.activeActions = true});

  final Matches match;
  final bool activeActions;

  final MatchesCallback matchesCallback = MatchesCallback();
  final MatchesHandler matchesHandler = MatchesHandler();
  final TeamsHandler teamsHandler = TeamsHandler();
  final FasiHandler fasiHandler = FasiHandler();

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<TeamsProvider>(context, listen: true);
    var matchesProvider = Provider.of<MatchesProvider>(context, listen: true);
    //var fasiProvider = Provider.of<FasiProvider>(context, listen: true);

    Teams? team1 = teamsHandler.getTeamById(teamsProvider, match.idTeam1);
    Teams? team2 = teamsHandler.getTeamById(teamsProvider, match.idTeam2);

    MatchesBet? matchBet =
        matchesHandler.getMatchBetByMatchId(matchesProvider, match.id);

    //Fasi? fase = fasiHandler.getFaseById(fasiProvider, match.fase);

    return GestureDetector(
      onTap: () async {
        if (activeActions) {
          await matchesCallback.onMatchTileTap(
              context, matchesProvider, match, matchBet);
        }
      },
      onLongPress: () async {
        if (activeActions) {
          await matchesCallback.onMatchTileLongPress(
              context, matchesProvider, match);
        }
      },
      child: Container(
        color: transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const EmptySpace(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TeamFlagName(
                        team: team1,
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
                      TeamFlagName(
                        team: team2,
                        nameOnLeft: true,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: matchBet != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check,
                          color: successColor,
                        ),
                        PalladioText(
                          "Risultato (${matchBet?.goalTeam1} : ${matchBet?.goalTeam2})",
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
                    visible: matchBet == null,
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
