import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_text.dart';
import 'package:responsive/responsive.dart';

class PalladioResponsiveFormField extends StatelessWidget {
  const PalladioResponsiveFormField({
    super.key,
    required this.fieldTitle,
    required this.formField,
  });

  final String fieldTitle;
  final Widget formField;

  @override
  Widget build(BuildContext context) {
    return FlexWidget(
      xs: 95,
      sm: 95,
      md: 45,
      lg: 45,
      xl: 45,
      xxl: 45,
      xxxl: 45,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PalladioText(
              fieldTitle,
              type: PTextType.h1,
              bold: true,
            ),
            formField,
          ],
        ),
      ),
    );
  }
}
