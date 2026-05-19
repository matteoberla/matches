import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_asset_image.dart';

class CharityCard extends StatelessWidget {
  const CharityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PalladioAssetImage(
              directory: "general",
              fileName: "cds_logo.jpg",
              width: width * 0.30,
            ),
            const Divider(),
            const Text(
              'Ci teniamo a ricordare che parte delle quote di partecipazione di ogni edizione vengono devolute in beneficenza alla Città della Speranza, fondazione impegnata nella ricerca oncologica pediatrica.',
              style: TextStyle(fontSize: 14, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
