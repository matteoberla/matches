import 'package:flutter/material.dart';

class PalladioAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PalladioAppBar(
      {super.key, required this.title, this.leading, this.actions, this.backgroundColor});

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: backgroundColor,
      leading: leading,
      title: Text(title,),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
