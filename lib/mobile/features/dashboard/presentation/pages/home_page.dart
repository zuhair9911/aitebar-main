import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_placeholder.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/bloc/funds_raising_posts/funds_raising_posts_cubit.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/widgets/funds_grid_tile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final FundsRaisingPostsCubit _fundsRaisingPostsCubit = sl<FundsRaisingPostsCubit>()..fetchFundsRaising(status: StatusType.approved);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              height: kToolbarHeight,
              child: SizedBox(
                height: kToolbarHeight * 0.8,
                width: context.width * 0.6,
                child: AppButton.primary(
                  borderRadius: BorderRadius.circular(8.0),
                  child: const Text(AppStrings.startAFundraiser),
                  onPressed: () {
                    context.router.navigate(CreateFundsRaisingRoute());
                  },
                ),
              ),
            ),
          ),
        ];
      },
      // The content of the scroll view
      body: BlocBuilder<FundsRaisingPostsCubit, FundsRaisingPostsState>(
        bloc: _fundsRaisingPostsCubit,
        builder: (context, state) {
          if (state is FundsRaisingPostsLoading) return const Center(child: CircularProgressIndicator());
          if (state.items.isEmpty) {
            return Center(
              child: AppPlaceholder(
                icon: const Icon(LineIcons.coins, size: 86.0),
                title: AppStrings.noFundsRaisingPosts,
                child: AppButton.outlineShrink(
                  height: 24,
                  child: const Text(AppStrings.refresh, style: TextStyle(fontSize: 12.0)),
                  onPressed: () => _fundsRaisingPostsCubit.fetchFundsRaising(status: StatusType.approved),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _fundsRaisingPostsCubit.fetchFundsRaising(status: StatusType.approved),
            child: MasonryGridView.count(
              crossAxisCount: context.width ~/ (context.isMobile ? 190.0 : 230),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return FundsGridTile(
                  fundsRaising: state.items[index],
                  onTap: () => context.router.navigate(FundsDetailsRoute(fundsRaising: state.items[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
