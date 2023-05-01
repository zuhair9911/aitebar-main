import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_placeholder.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/bloc/user_funds_requests/user_funds_requests_cubit.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/widgets/funds_request_grid_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class RequestedFundsPage extends StatefulWidget {
  const RequestedFundsPage({super.key});

  @override
  State<RequestedFundsPage> createState() => _RequestedFundsPageState();
}

class _RequestedFundsPageState extends State<RequestedFundsPage> {
  final UserFundsRequestsCubit _fundsRaisingCubit = sl<UserFundsRequestsCubit>();

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserFundsRequestsCubit, UserFundsRequestsState>(
        bloc: _fundsRaisingCubit,
        builder: (context, state) {
          if (state == const UserFundsRequestsState.loading()) {
            return MasonryGridView.count(
              crossAxisCount: context.width ~/ (context.isMobile ? 190.0 : 230),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const FundsRequestGridTile.skeleton();
              },
            );
          }
          if (state.items.isEmpty) {
            return Center(
              child: AppPlaceholder(
                icon: const Icon(LineIcons.coins, size: 86.0),
                title: AppStrings.noFundsRequestFound,
                child: AppButton.outlineShrink(
                  height: 24,
                  onPressed: _fetchItems,
                  child: const Text(AppStrings.refresh, style: TextStyle(fontSize: 12.0)),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => _fetchItems(),
            child: MasonryGridView.count(
              crossAxisCount: context.width ~/ (context.isMobile ? 190.0 : 230),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return FundsRequestGridTile(
                  fundsRequest: state.items[index],
                  onTap: () => context.router.navigate(
                    AVFundsRequestDetailsRoute(fundsRequest: state.items[index], isAdmin: false),
                  ),
                  onEdit: () {
                    context.router.navigate(CreateFundsRequestRoute(fundsRequest: state.items[index]));
                  },
                  // onTap: () => context.router.navigate(FundsDetailsRoute(fundsRaising: state.items[index])),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.navigate(CreateFundsRequestRoute()),
        child: const Icon(LineIcons.plus),
      ),
    );
  }

  void _fetchItems() {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid?.isEmpty ?? true) return;
    _fundsRaisingCubit.fetchFundsRequest(uid: uid);
  }
}
