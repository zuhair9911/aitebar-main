import 'dart:math';

import 'package:aitebar/core/bloc/search/search_cubit.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key? key}) : super(key: key);
  final SearchCubit _searchCubit = sl<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: _searchCubit,
      builder: (context, state) {
        return state.isSearching
            ? _AppBarSearch(
                onChange: _searchCubit.onChanged,
              )
            : AppBar(
                title: Image.asset(
                  Assets.app.appLogo.path,
                  height: kToolbarHeight * 0.8,
                  color: context.primary,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(LineIcons.search),
                    onPressed: () {
                      _searchCubit.startSearching();
                    },
                  ),
                ],
              );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarSearch({this.onChange, Key? key}) : super(key: key);
  final Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: SizedBox(
          width: min(context.width, 400.0),
          child: Theme(
            data: Theme.of(context).copyWith(inputDecorationTheme: const InputDecorationTheme()),
            child: TextFormField(
              onChanged: onChange,
              decoration: InputDecoration(
                hintText: 'Search',
                fillColor: context.primary.withOpacity(0.1),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                suffixIcon: IconButton(
                  icon: const Icon(LineIcons.times),
                  onPressed: sl<SearchCubit>().stopSearching,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
