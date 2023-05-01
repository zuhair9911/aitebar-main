import 'package:aitebar/core/logging/logger.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NavigationObserver extends AutoRouterObserver {
  late final Logger log;

  NavigationObserver() {
    log = getLogger("Navigation Observer");
  }
  @override
  void didPush(Route route, Route? previousRoute) {
    log.i('New route pushed: ${route.settings.name}');
    log.i('New route pushed P: ${previousRoute?.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log.i('Tab route visited: ${route.name}');
    log.i('Tab route visited P: ${previousRoute?.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log.i('Tab route re-visited: ${route.name}');
  }
}
