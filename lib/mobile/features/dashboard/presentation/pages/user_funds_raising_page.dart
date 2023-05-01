import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_placeholder.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/bloc/user_funds_raising/user_funds_raising_cubit.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/widgets/funds_grid_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class UserFundsRaisingPage extends StatelessWidget {
  UserFundsRaisingPage({Key? key}) : super(key: key);

  final UserFundsRaisingCubit _fundsRaisingPostsCubit = sl<UserFundsRaisingCubit>()..fetchAllFundsRaisingPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.navigate(CreateFundsRaisingRoute());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<UserFundsRaisingCubit, UserFundsRaisingState>(
        bloc: _fundsRaisingPostsCubit,
        builder: (context, state) {
          if (state is UserFundsRaisingError) {
            return Center(
              child: AppPlaceholder(
                icon: const Icon(LineIcons.exclamationCircle, size: 86.0),
                title: state.message,
                child: AppButton.outlineShrink(
                  height: 24,
                  child: const Text(AppStrings.refresh, style: TextStyle(fontSize: 12.0)),
                  onPressed: () => _fundsRaisingPostsCubit.fetchAllFundsRaisingPosts(),
                ),
              ),
            );
          } else if (state is UserFundsRaisingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.items.isEmpty) {
            return const Center(
              child: AppPlaceholder(
                icon: Icon(LineIcons.coins, size: 86.0),
                title: AppStrings.youHaveNoFundsRaisingPosts,
                subtitle: AppStrings.yourFundsRaisingPostsWillBeShownHere,
              ),
            );
          }
          return MasonryGridView.count(
            crossAxisCount: context.width ~/ (context.isMobile ? 190.0 : 230),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return FundsGridTile(
                onEdit: () {
                  context.router.navigate(CreateFundsRaisingRoute(fundsRaising: state.items[index]));
                },
                fundsRaising: state.items[index],
                onTap: () => context.router.navigate(FundsDetailsRoute(fundsRaising: state.items[index])),
              );
            },
          );
        },
      ),
    );
  }
}
