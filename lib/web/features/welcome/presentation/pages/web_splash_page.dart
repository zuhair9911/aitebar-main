import 'package:aitebar/core/routes/web_routes/web_router.gr.dart';
import 'package:aitebar/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WebSplashPage extends StatelessWidget {
  const WebSplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser != null) {
        context.router.replace(AuthRoute());
      } else {
        context.router.replace(AuthRoute());
      }
    });
    return Scaffold(
      body: Center(
        child: Image.asset(Assets.app.appLogo.path, height: 120.0),
      ),
    );
  }
}
