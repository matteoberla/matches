import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matches/controllers/fasi_handlers/fasi_requests.dart';
import 'package:matches/models/fasi_models/fasi_model.dart';
import 'package:matches/state_management/fasi_provider/fasi_provider.dart';
import 'package:provider/provider.dart';

class FasiHandler {
  Future saveAllFasi(BuildContext context) async {
    var fasiProvider = Provider.of<FasiProvider>(context, listen: false);
    FasiRequests fasiRequests = FasiRequests();

    Map<String, String> params = {};

    http.Response fasiResponse = await fasiRequests.getFasiList(params);

    if (fasiResponse.statusCode == 200) {
      FasiModel fasiModel = FasiModel.fromJson(json.decode(fasiResponse.body));
      fasiProvider.overrideFasiList(fasiModel.fasi ?? []);
    }
  }

  Fasi? getFaseById(FasiProvider provider, int? id) {
    return provider.fasiList.where((element) => element.id == id).firstOrNull;
  }
}
