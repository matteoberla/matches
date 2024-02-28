import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_bottom_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_loading.dart';
import 'package:matches/state_management/http_provider/http_provider.dart';
import 'package:provider/provider.dart';

class PalladioBody extends StatelessWidget {
  const PalladioBody({
    super.key,
    required this.child,
    this.showBottomBar = true,
  });

  final Widget child;
  final bool? showBottomBar;

  @override
  Widget build(BuildContext context) {
    var httpProvider = Provider.of<HttpProvider>(context, listen: true);

    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: child),
            Visibility(
              visible: showBottomBar == true,
              child: PalladioBottomBar(),
            ),
          ],
        ),
        if (httpProvider.isLoading)
          PalladioLoading(absorbing: httpProvider.isLoading),
      ],
    );
  }
}
