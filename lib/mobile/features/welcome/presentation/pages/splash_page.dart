import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/gen/assets.gen.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/user/user_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authBloc = sl<AuthBloc>();

  late final UserCubit _userCubit;

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
    Future.delayed(const Duration(seconds: 3), () {
      if (_userCubit.isAuthorized) {
        _authBloc.add(AuthEvent.fetchUser(uid: _userCubit.uid!));
      } else {
        debugPrint('SplashScreen.build: not authorized');
        context.router.navigate(const WelcomeRoute());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(gradient: context.vertical),
              child: Center(child: Image.asset(Assets.app.appLogo.path, height: context.width * 0.6)),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 0.0,
            right: 0.0,
            child: BlocConsumer<AuthBloc, AuthState>(
              bloc: _authBloc,
              listener: (context, state) {
                state.whenOrNull(
                  success: (AppUser user) {
                    debugPrint('SplashScreen.build -> success');
                    context.router.replaceAll([DashboardRoute()]);
                    _userCubit.init(user);
                  },
                  failure: (message) async {
                    debugPrint('SplashScreen.build: failure');
                    context.showSnackBar(message);
                    context.router.navigate(const WelcomeRoute());
                    await _userCubit.logout();
                  },
                );
              },
              builder: (_, __) {
                return Center(child: CircularProgressIndicator(color: context.onPrimary));
              },
            ),
          ),
        ],
      ),
    );
  }
}
