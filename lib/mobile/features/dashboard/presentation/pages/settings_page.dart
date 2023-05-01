import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/user/user_cubit.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/pages/about_us.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/pages/privacy_policy.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/pages/terms%20_and_conditions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Settings Page', style: context.titleMedium),
          ),
          // ListTile(
          //   leading: const Icon(LineIcons.user),
          //   title: const Text('Profile'),
          //   onTap: () {},
          //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          // ),
          ListTile(
            leading: const Icon(LineIcons.fileAlt),
            title: const Text('Terms and conditions'),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const TermsAndConditions();
                },
              ));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
          ),
          ListTile(
            leading: const Icon(LineIcons.userShield),
            title: const Text('Privacy policy'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const PrivacyPolicy();
                },
              ));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
          ),
          ListTile(
            leading: const Icon(LineIcons.infoCircle),
            title: const Text('About us'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const AboutUs();
                },
              ));

            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
          ),
          ListTile(
            leading: const Icon(LineIcons.alternateSignOut),
            title: const Text(AppStrings.logout),
            onTap: () {
              context.read<UserCubit>().logout().then((_) {
                context.router.replaceAll([const WelcomeRoute()]);
              });
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
          ),
        ],
      ),
    );
  }
}
