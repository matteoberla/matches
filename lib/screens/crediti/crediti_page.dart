import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_asset_image.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/styles.dart';

class CreditiPage extends StatefulWidget {
  const CreditiPage({super.key});

  @override
  State<CreditiPage> createState() => _CreditiPageState();
}

class _CreditiPageState extends State<CreditiPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _key,
        appBar: PalladioAppBar(
          title: "Crediti",
          backgroundColor: canvasColor,
          leading: IconButton(
            onPressed: () {
              setupCallback.onMenuPressed(context, _key);
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        body: PalladioBody(
          child: Column(
            children: [
              PalladioAssetImage(
                directory: "general",
                fileName: "cds_logo.jpg",
                width: width * 0.65,
              )
            ],
          ),
        ),
        drawer: PalladioDrawer(
          drawerKey: _key,
        ),
      ),
    );
  }
}
