import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_drawer.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:matches/controllers/setup_handlers/setup_callback.dart';
import 'package:matches/models/points_models/points_model.dart';
import 'package:matches/state_management/points_provider/points_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //
  SetupCallback setupCallback = SetupCallback();

  //
  ItemScrollController scrollController = ItemScrollController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var pointsProvider = Provider.of<PointsProvider>(context, listen: true);
    return Scaffold(
      key: _key,
      appBar: PalladioAppBar(
        title: "Partecipanti",
        backgroundColor: canvasColor,
        leading: IconButton(
          onPressed: () {
            setupCallback.onMenuPressed(context, _key);
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: PalladioBody(
        child: ScrollablePositionedList.builder(
          itemScrollController: scrollController,
          itemCount:
              pointsProvider.pointsList.where((e) => e.isActive == 1).length,
          itemBuilder: (context, index) {
            Points points = pointsProvider.pointsList
                .where((e) => e.isActive == 1)
                .toList()[index];

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
