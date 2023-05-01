import 'package:aitebar/core/bloc/search/search_cubit.dart';
import 'package:aitebar/core/components/app_general_dialog.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/users/users_cubit.dart';
import 'package:aitebar/web/features/dashboard/presentation/widgets/user_details_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class UserPage extends StatelessWidget {
  UserPage({super.key});

  final _usersCubit = sl<UsersCubit>()..fetchUsers();
  final SearchCubit _searchCubit = sl<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      bloc: _usersCubit,
      builder: (context, state) {
        return BlocBuilder<SearchCubit, SearchState>(
          bloc: _searchCubit,
          builder: (context, searching) {
            List<AppUser> searchedItems = state.users.where((item) {
              if (searching.query.isEmpty) return true;
              return item.name.toString().toLowerCase().contains(searching.query) ||
                  item.email.toString().toLowerCase().contains(searching.query) ||
                  (item.createdAt?.format().toString().contains(searching.query) ?? false);
            }).toList();
            _UsersSource dataSource = _UsersSource(searchedItems);
            return SfDataGrid(
              source: dataSource,
              columnWidthMode: context.isMobile ? ColumnWidthMode.fitByCellValue : ColumnWidthMode.fill,
              onCellTap: (DataGridCellTapDetails args) {
                int index = args.rowColumnIndex.rowIndex - 1;
                if (index < 0) return;
                showAppGeneralDialog(context, child: UserDetails(user: searchedItems[index]));
              },
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'uid',
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text('UID'),
                  ),
                ),
                GridColumn(
                  columnName: 'name',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Name', maxLines: 2, textAlign: TextAlign.center),
                  ),
                ),
                GridColumn(
                  columnName: 'email',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Email', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2),
                  ),
                ),
                GridColumn(
                  columnName: 'createdAt',
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text('Created At'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _UsersSource extends DataGridSource {
  _UsersSource(List<AppUser> items) {
    _items = items
        .map<DataGridRow>(
          (user) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'uid', value: user.uid),
              DataGridCell(columnName: 'name', value: user.name),
              DataGridCell(columnName: 'email', value: user.email),
              DataGridCell(columnName: 'createdAt', value: user.createdAt?.format()),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _items = [];

  @override
  List<DataGridRow> get rows => _items;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final int rowIndex = _items.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if ((rowIndex % 2) == 0) {
      backgroundColor = Colors.grey.withOpacity(0.1);
    }
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        color: backgroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString(), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }
}
