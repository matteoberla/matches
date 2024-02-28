import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/points_handlers/points_callback.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/models/points_models/points_model.dart';
import 'package:matches/state_management/points_provider/points_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class PointsListPage extends StatefulWidget {
  const PointsListPage({super.key});

  @override
  State<PointsListPage> createState() => _PointsListPageState();
}

class _PointsListPageState extends State<PointsListPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();
  PointsCallback pointsCallback = PointsCallback();

  @override
  Widget build(BuildContext context) {
    var pointsProvider = Provider.of<PointsProvider>(context, listen: true);
    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Classifica",
        backgroundColor: canvasColor,
        leading: IconButton(
          onPressed: () {
            setupCallback.onMenuPressed(context, _key);
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: PalladioBody(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: pointsProvider.pointsList.length,
          itemBuilder: (context, index) {
            Points points = pointsProvider.pointsList[index];

            return ListTile(
              leading: PalladioText(
                (index + 1).toString(),
                type: PTextType.h2,
                bold: true,
              ),
              title: PalladioText(
                points.username ?? "",
                type: PTextType.h2,
              ),
              subtitle: Row(
                children: [
                  Visibility(
                    visible: points.isActive == 0,
                    child: const Icon(
                      Icons.close,
                      color: dangerColor,
                    ),
                  ),
                  PalladioText(
                    "${points.totalPoints} punti",
                    type: PTextType.h3,
                    textColor: opaqueTextColor,
                  ),
                ],
              ),
              onTap: () {
                pointsCallback.onUserPointsTap(context, points);
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
        ),
      ),
      drawer: PalladioDrawer(
        drawerKey: _key,
      ),
    );
  }
}
