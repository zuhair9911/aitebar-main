import 'package:aitebar/core/bloc/search/search_cubit.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/core/extensions/string_extension.dart';
import 'package:aitebar/core/routes/web_routes/web_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/funds_raising/funds_raising_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class AllFundsRaisingPage extends StatelessWidget {
  AllFundsRaisingPage({super.key});

  final _fundRaisingCubit = sl<FundsRaisingCubit>()..fetchFundsRaising();
  final SearchCubit _searchCubit = sl<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsRaisingCubit, FundsRaisingState>(
      bloc: _fundRaisingCubit,
      builder: (context, state) {
        return BlocBuilder<SearchCubit, SearchState>(
          bloc: _searchCubit,
          builder: (context, searching) {
            List<FundsRaising> searchedItems = state.items.where((item) {
              if (searching.query.isEmpty) return true;
              return item.title.toLowerCase().contains(searching.query) ||
                  item.id.referenceId.toLowerCase().contains(searching.query) ||
                  item.requireAmount.toString().contains(searching.query) ||
                  item.raisedAmount.toString().contains(searching.query) ||
                  item.status.value.toLowerCase().contains(searching.query) ||
                  item.address.toLowerCase().contains(searching.query) ||
                  (item.createdAt?.format().toString().contains(searching.query) ?? false)||
                  item.category.toLowerCase().contains(searching.query);
            }).toList();
            _FundsRaidingDataSource dataSource = _FundsRaidingDataSource(searchedItems);
            return SfDataGrid(
              source: dataSource,
              columnWidthMode: ColumnWidthMode.auto,
              onCellTap: (DataGridCellTapDetails args) {
                int index = args.rowColumnIndex.rowIndex - 1;
                if (index < 0) return;
                context.router.navigate(AVFundsDetailsRoute(fundsRaising: searchedItems[index]));
              },
              columns: <GridColumn>[
                GridColumn(
                  columnName: AppStrings.title,
                  width: 250.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.title),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.referenceId,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.referenceId),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.requireAmount,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.raisedAmount, maxLines: 2, textAlign: TextAlign.center),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.raisedAmount,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.requireAmount, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.status,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.status),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.category,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.category),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.address,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.address),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.description,
                  width: 250.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.description),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.createdAt,
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.createdAt),
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

class _FundsRaidingDataSource extends DataGridSource {
  _FundsRaidingDataSource(List<FundsRaising> items) {
    _items = items
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              // DataGridCell(columnName: 'uid', value: e.uid),
              DataGridCell(columnName: AppStrings.title, value: e.title),
              DataGridCell(columnName: AppStrings.referenceId, value: e.referenceId ?? e.id.referenceId),
              DataGridCell(columnName: AppStrings.raisedAmount, value: '\$${e.raisedAmount}'),
              DataGridCell(columnName: AppStrings.requireAmount, value: '\$${e.requireAmount}'),
              DataGridCell<Widget>(
                columnName: AppStrings.status,
                value: Container(
                  color: e.status.color.withOpacity(0.1),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.status.value.toUpperCase(), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                ),
              ),
              DataGridCell(columnName: AppStrings.category, value: e.category),
              DataGridCell(columnName: AppStrings.address, value: e.address),
              DataGridCell(columnName: AppStrings.description, value: e.description),
              DataGridCell(columnName: AppStrings.createdAt, value: e.createdAt?.format()),
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
      return e.value is Widget
          ? e.value
          : Container(
              color: backgroundColor,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString(), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
            );
    }).toList());
  }
}
