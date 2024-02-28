import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/components/empty_space.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/components/team_components/team_flag_name.dart';
import 'package:matches/controllers/alerts.dart';
import 'package:matches/controllers/gironi_handlers/gironi_bottom_sheets_handler.dart';
import 'package:matches/controllers/gironi_handlers/gironi_callback.dart';
import 'package:matches/controllers/gironi_handlers/gironi_requests.dart';
import 'package:matches/controllers/points_handlers/points_handler.dart';
import 'package:matches/controllers/teams_handlers/teams_handler.dart';
import 'package:matches/models/gironi_models/gironi_bet_model.dart';
import 'package:matches/models/gironi_models/gironi_model.dart';
import 'package:matches/models/teams_models/teams_model.dart';
import 'package:matches/state_management/gironi_provider/gironi_provider.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:matches/state_management/teams_provider/teams_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class GironiHandler {
  Future saveAllGironi(BuildContext context) async {
    var gironiProvider = Provider.of<GironiProvider>(context, listen: false);
    GironiRequests gironiRequests = GironiRequests();

    Map<String, String> params = {};

    http.Response gironiResponse = await gironiRequests.getGironiList(params);

    if (gironiResponse.statusCode == 200) {
      GironiModel gironiModel =
          GironiModel.fromJson(json.decode(gironiResponse.body));
      gironiProvider.overrideGironiList(gironiModel.gironi ?? []);
    }
  }

  Future saveAllGironiBet(BuildContext context) async {
    var gironiProvider = Provider.of<GironiProvider>(context, listen: false);
    GironiRequests gironiRequests = GironiRequests();

    Map<String, String> params = {};

    http.Response gironiBetResponse =
        await gironiRequests.getGironiBetList(params);

    if (gironiBetResponse.statusCode == 200) {
      GironiBetModel gironiBetModel =
          GironiBetModel.fromJson(json.decode(gironiBetResponse.body));
      gironiProvider.overrideGironiBetList(gironiBetModel.gironiBet ?? []);
    }
  }

  GironiBet? getGironeBetFromGirone(GironiProvider provider, String? girone) {
    return provider.gironiBetList
        .where((element) => element.girone == girone)
        .firstOrNull;
  }

  //get teams list
  Widget getGironeTile(
    BuildContext context,
    TeamsProvider teamsProvider,
    GironiProvider gironiProvider,
    Gironi girone,
  ) {
    //
    TeamsHandler teamsHandler = TeamsHandler();
    GironiCallback gironiCallback = GironiCallback();
    GironiBet? gironeBet =
        getGironeBetFromGirone(gironiProvider, girone.girone);

    List<Map<String, int>> teamPositions = [
      {
        "pos": girone.pos1 ?? -1,
        "team": girone.idTeam1 ?? -1,
        "bet": gironeBet?.pos1 ?? -1
      },
      {
        "pos": girone.pos2 ?? -1,
        "team": girone.idTeam2 ?? -1,
        "bet": gironeBet?.pos2 ?? -1
      },
      {
        "pos": girone.pos3 ?? -1,
        "team": girone.idTeam3 ?? -1,
        "bet": gironeBet?.pos3 ?? -1
      },
      {
        "pos": girone.pos4 ?? -1,
        "team": girone.idTeam4 ?? -1,
        "bet": gironeBet?.pos4 ?? -1
      },
    ];
    //ordinamento per posizione effettiva
    teamPositions.sort((a, b) => (a['bet'])!.compareTo(b['bet']!));
    //
    List<Widget> teamsWidgets = [];

    for (var team in teamPositions) {
      Teams? teamModel = teamsHandler.getTeamById(teamsProvider, team["team"]);
      //
      String finalPos = team["pos"] != -1 ? team["pos"].toString() : "";
      String betPos = team["bet"] != -1 ? team["bet"].toString() : "???";

      teamsWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: teamPositions.first == team,
              child: const PalladioText(
                "Pos. finale",
                type: PTextType.h2,
                bold: true,
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PalladioText(finalPos, type: PTextType.h2),
                        const EmptySpace(
                          width: 10,
                        ),
                        TeamFlagName(
                          team: teamModel,
                          align: MainAxisAlignment.start,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PalladioText(betPos, type: PTextType.h2),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget betTile = GestureDetector(
      onTap: () {
        gironiCallback.onGironeTileTap(
            context, gironiProvider, girone, gironeBet);
      },
      onLongPress: () async {
        await gironiCallback.onGironeTileLongPress(
            context, gironiProvider, girone);
      },
      child: Container(
        color: transparent,
        child: Column(
          children: [
            ...teamsWidgets,
            Visibility(
              visible: gironeBet != null,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: successColor,
                  ),
                  PalladioText(
                    "Risultato inserito",
                    type: PTextType.h3,
                    textColor: opaqueTextColor,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: gironeBet?.points != null,
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
                    "Punti: ${gironeBet?.points}",
                    type: PTextType.h3,
                    textColor: opaqueTextColor,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: gironeBet == null,
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
    );

    return betTile;
  }

  showBetBottomSheet(BuildContext context, GironiProvider provider,
      Gironi girone, GironiBet? gironiBet) async {
    provider.updateSelectedGirone(girone);
    //
    initializeAllGironeBetValues(provider, gironiBet);
    provider.updateSelectedGironeBet(gironiBet);

    GironiBottomSheetsHandler gironiBottomSheetsHandler =
        GironiBottomSheetsHandler();
    await gironiBottomSheetsHandler.showBetBottomSheet(context, provider);
  }

  initializeAllGironeBetValues(GironiProvider provider, GironiBet? gironeBet) {
    gironeBet?.pos1Controller.text =
        gironeBet.pos1 != null ? gironeBet.pos1.toString() : "";
    gironeBet?.pos2Controller.text =
        gironeBet.pos2 != null ? gironeBet.pos2.toString() : "";
    gironeBet?.pos3Controller.text =
        gironeBet.pos3 != null ? gironeBet.pos3.toString() : "";
    gironeBet?.pos4Controller.text =
        gironeBet.pos4 != null ? gironeBet.pos4.toString() : "";
  }

  showGironeBottomSheet(
      BuildContext context, GironiProvider provider, Gironi girone) async {
    initializeAllGironeValues(provider, girone);
    provider.updateSelectedGirone(girone);

    GironiBottomSheetsHandler gironiBottomSheetsHandler =
        GironiBottomSheetsHandler();
    await gironiBottomSheetsHandler.showGironeBottomSheet(context, provider);
  }

  initializeAllGironeValues(GironiProvider provider, Gironi girone) {
    girone.pos1Controller.text =
        girone.pos1 != null ? girone.pos1.toString() : "";
    girone.pos2Controller.text =
        girone.pos2 != null ? girone.pos2.toString() : "";
    girone.pos3Controller.text =
        girone.pos3 != null ? girone.pos3.toString() : "";
    girone.pos4Controller.text =
        girone.pos4 != null ? girone.pos4.toString() : "";
  }

  ///gironebet
  Future<bool> checkMandatoryFieldsOfGironeBet(GironiProvider provider) async {
    GironiBet? currentGironeBet = provider.selectedGironeBet;

    String pos1 = currentGironeBet?.pos1Controller.text ?? "";
    String pos2 = currentGironeBet?.pos2Controller.text ?? "";
    String pos3 = currentGironeBet?.pos3Controller.text ?? "";
    String pos4 = currentGironeBet?.pos4Controller.text ?? "";

    bool missingPos1 = pos1 == "";
    bool missingPos2 = pos2 == "";
    bool missingPos3 = pos3 == "";
    bool missingPos4 = pos4 == "";

    if (missingPos1 || missingPos2 || missingPos3 || missingPos4) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare la posizione di tutte le squadre.");
      return false;
    }

    List<String> positions = [pos1, pos2, pos3, pos4];
    if (positions.length != positions.toSet().length) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Tutte le posizioni devono essere diverse.");
      return false;
    }
    return true;
  }

  verifyGironeBet(BuildContext context, GironiProvider provider) async {
    bool success = await checkMandatoryFieldsOfGironeBet(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveGironeBet(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool> saveGironeBet(
      BuildContext context, GironiProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedGironeBet == null) return false;

    httpProvider.updateLoadingState(true);

    GironiRequests gironiRequests = GironiRequests();

    http.Response saveGironiBetResponse;

    provider.selectedGironeBet?.pos1 =
        int.tryParse(provider.selectedGironeBet?.pos1Controller.text ?? "");
    provider.selectedGironeBet?.pos2 =
        int.tryParse(provider.selectedGironeBet?.pos2Controller.text ?? "");
    provider.selectedGironeBet?.pos3 =
        int.tryParse(provider.selectedGironeBet?.pos3Controller.text ?? "");
    provider.selectedGironeBet?.pos4 =
        int.tryParse(provider.selectedGironeBet?.pos4Controller.text ?? "");

    if (provider.selectedGironeBet?.id == null) {
      //inserimento
      saveGironiBetResponse =
          await gironiRequests.insertGironeBet(provider.selectedGironeBet!);
    } else {
      //modifica
      saveGironiBetResponse =
          await gironiRequests.editGironeBet(provider.selectedGironeBet!);
    }

    httpProvider.updateLoadingState(false);
    if (saveGironiBetResponse.statusCode == 200) {
      //ricarico lista gironibet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllGironiBet(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }

  ///girone
  Future<bool> checkMandatoryFieldsOfGirone(GironiProvider provider) async {
    Gironi? currentGirone = provider.selectedGirone;

    String pos1 = currentGirone?.pos1Controller.text ?? "";
    String pos2 = currentGirone?.pos2Controller.text ?? "";
    String pos3 = currentGirone?.pos3Controller.text ?? "";
    String pos4 = currentGirone?.pos4Controller.text ?? "";

    bool missingPos1 = pos1 == "";
    bool missingPos2 = pos2 == "";
    bool missingPos3 = pos3 == "";
    bool missingPos4 = pos4 == "";

    if (missingPos1 || missingPos2 || missingPos3 || missingPos4) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare la posizione di tutte le squadre.");
      return false;
    }

    List<String> positions = [pos1, pos2, pos3, pos4];
    if (positions.length != positions.toSet().length) {
      await Alerts.showInfoAlertNoContext(
          "Attenzione", "Tutte le posizioni devono essere diverse.");
      return false;
    }
    return true;
  }

  verifyGirone(BuildContext context, GironiProvider provider) async {
    bool success = await checkMandatoryFieldsOfGirone(provider);
    if (success == false) return;

    if (context.mounted && success == true) {
      bool saved = await saveGirone(context, provider);
      if (context.mounted && saved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool> saveGirone(BuildContext context, GironiProvider provider) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    if (provider.selectedGirone == null) return false;

    httpProvider.updateLoadingState(true);

    GironiRequests gironiRequests = GironiRequests();

    http.Response saveGironeResponse;

    provider.selectedGirone?.girone =
        provider.selectedGirone?.gironeController.text ?? "";
    provider.selectedGirone?.pos1 =
        int.tryParse(provider.selectedGirone?.pos1Controller.text ?? "");
    provider.selectedGirone?.pos2 =
        int.tryParse(provider.selectedGirone?.pos2Controller.text ?? "");
    provider.selectedGirone?.pos3 =
        int.tryParse(provider.selectedGirone?.pos3Controller.text ?? "");
    provider.selectedGirone?.pos4 =
        int.tryParse(provider.selectedGirone?.pos4Controller.text ?? "");

    if (provider.selectedGirone?.id == null) {
      //inserimento
      saveGironeResponse =
          await gironiRequests.insertGirone(provider.selectedGirone!);
    } else {
      //modifica
      saveGironeResponse =
          await gironiRequests.editGirone(provider.selectedGirone!);
    }

    httpProvider.updateLoadingState(false);
    if (saveGironeResponse.statusCode == 200) {
      //ricarico lista matchbet
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllGironi(context);
      }
      if (context.mounted) {
        await saveAllGironiBet(context);
      }
      if (context.mounted) {
        PointsHandler pointsHandler = PointsHandler();
        await pointsHandler.saveAllPoints(context);
      }
      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }

  ///
  Future<bool> deleteGirone(
      BuildContext context, GironiProvider provider, Gironi girone) async {
    var httpProvider = Provider.of<HttpProvider>(context, listen: false);

    httpProvider.updateLoadingState(true);

    GironiRequests gironiRequests = GironiRequests();

    http.Response deleteMatchResponse;

    deleteMatchResponse = await gironiRequests.deleteGirone(girone);

    httpProvider.updateLoadingState(false);
    if (deleteMatchResponse.statusCode == 200) {
      //ricarico lista gironi
      httpProvider.updateLoadingState(true);
      if (context.mounted) {
        await saveAllGironi(context);
      }

      httpProvider.updateLoadingState(false);

      return true;
    }

    return false;
  }
}
