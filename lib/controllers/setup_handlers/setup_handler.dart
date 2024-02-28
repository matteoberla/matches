import 'package:flutter/material.dart';
import 'package:matches/state_management/setup_provider/setup_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class SetupHandler {
  Future<bool> initSetupPage(BuildContext context) async {
    await getAppInfo(context);

    return true;
  }


  Future<bool> getAppInfo(BuildContext context) async {
    var setupProvider = Provider.of<SetupProvider>(context, listen: false);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print(version);

    setupProvider.updateAppInfo(version, buildNumber);

    return true;
  }

}
