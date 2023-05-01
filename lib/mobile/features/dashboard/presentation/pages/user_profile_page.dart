import 'package:aitebar/core/components/app_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 100.0),
          Center(
            child: AppImage.network(
              imageUrl: 'https://picsum.photos/250?image=9',
              width: 100.0,
              height: 100.0,
            ),
          ),
          const SizedBox(height: 100.0),
        ],
      )),
    );
  }
}
