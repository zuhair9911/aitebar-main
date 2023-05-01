import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/user/user_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final List<String> tiles;
  final void Function(int index)? onTap;

  const AppDrawer({
    Key? key,
    required this.tiles,
    this.onTap,
    this.selectedIndex = 0,
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
                      BlocSelector<UserCubit, UserState, AppUser?>(
                        selector: (state) => state.user,
                        builder: (context, user) {
                          if (user == null) {
                            return const ListTile(
                              title: Text('Login is required'),
                            );
                          }
                          return ListTile(
                            leading: const CircleAvatar(child: Icon(LineIcons.user)),
                            title: Text('${user.name}', maxLines: 1, overflow: TextOverflow.ellipsis),
                            subtitle: Text('${user.email}', maxLines: 1, overflow: TextOverflow.ellipsis),
                          );
                        },
                      ),
                      Divider(
                        color: context.primary.withOpacity(0.2),
                      ),
                      ListView.builder(
                        itemCount: tiles.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(tiles[index]),
                            onTap: () => onTap?.call(index),
                            selected: selectedIndex == index,
                            selectedTileColor: selectedIndex == index ? context.primary.withOpacity(0.2) : null,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(LineIcons.alternateSignOut),
                title: const Text(AppStrings.logout),
                onTap: () {
                  context.read<UserCubit>().logout().then((_) {
                    context.router.replaceAll([const WelcomeRoute()]);
                  });
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
