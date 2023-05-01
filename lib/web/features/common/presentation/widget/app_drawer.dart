import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final List<Widget> tiles;
  final void Function(int index)? onTap;
  final Widget? userTile;
  final Widget? logoutTile;

  const AppDrawer({
    Key? key,
    required this.tiles,
    this.onTap,
    this.selectedIndex = 0,
    this.userTile,
    this.logoutTile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 300.0,
      height: context.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: context.background,
        border: Border.all(color: context.primary.withOpacity(0.2)),
      ),
      child: Material(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (userTile != null) ...[
                        userTile!,
                        Divider(
                          color: context.primary.withOpacity(0.2),
                        ),
                      ],
                      ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: tiles,
                      ),
                    ],
                  ),
                ),
              ),
              if (logoutTile != null) ...{const Divider(), logoutTile!},
            ],
          ),
        ),
      ),
    );
  }
}
