import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? endDrawer;
  final Widget? drawer;

  const AppScaffold({
    this.appBar,
    this.body,
    this.endDrawer,
    this.drawer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return Row(
        children: [
          if (drawer != null) Material(child: drawer!),
          Expanded(
            child: Scaffold(
              appBar: appBar,
              body: body,
            ),
          ),
          if (endDrawer != null) Material(child: endDrawer!),
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      endDrawer: endDrawer,
      drawer: drawer,
      body: body,
    );
  }
}
