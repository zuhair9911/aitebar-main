import 'dart:math';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Assets.app.appLogoPrimary.path,
          height: kToolbarHeight * 0.8,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(Assets.png.wallpaper.path),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
          child: Column(
            children: [
              Text(
                'آپ کا اعتبار ہمارے ساتھ۔',
                style: context.titleLarge?.copyWith(fontSize: 30.0, color: context.onPrimary),
              ),
              const SizedBox(height: 24.0),
              AppButton(
                width: min(context.width, 300.0),
                onPressed: () => context.router.replaceAll([DashboardRoute()]),
                child: const Text(AppStrings.viewFundRaising),
              ),
              const SizedBox(height: 24.0),
              AppButton(
                width: min(context.width, 300.0),
                onPressed: () => context.router.replaceAll([DashboardRoute(initialIndex: 1), CreateFundsRaisingRoute()]),
                child: const Text(AppStrings.startAFundraiser),
              ),
              const SizedBox(height: 24.0),
              AppButton(
                width: min(context.width, 300.0),
                onPressed: () => context.router.replaceAll([DashboardRoute()]),
                child: const Text(AppStrings.fundsRequest),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
