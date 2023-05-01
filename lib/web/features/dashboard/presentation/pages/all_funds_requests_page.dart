import 'package:aitebar/core/bloc/search/search_cubit.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/core/routes/web_routes/web_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/funds_requests/funds_requests_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class AllFundsRequestsPage extends StatelessWidget {
  AllFundsRequestsPage({super.key});

  final _fundsRequestCubit = sl<FundsRequestsCubit>()..getAllFundsRequests();
  final SearchCubit _searchCubit = sl<SearchCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsRequestsCubit, FundsRequestsState>(
      bloc: _fundsRequestCubit,
      builder: (context, state) {
        return BlocBuilder<SearchCubit, SearchState>(
          bloc: _searchCubit,
          builder: (context, searching) {
            List<FundsRequest> searchedItems = state.items.where((item) {
              if (searching.query.isEmpty) return true;
              return item.title.toLowerCase().contains(searching.query) ||
                  item.requestedAmount.toString().contains(searching.query) ||
                  item.status.value.toLowerCase().contains(searching.query) ||
                  (('zakat').contains(searching.query) && item.isZakatEligible == true) ||
                  (item.createdAt?.format().toString().contains(searching.query) ?? false) ||
                  item.category.toLowerCase().contains(searching.query);
            }).toList();
            _FundsRequestsSource dataSource = _FundsRequestsSource(searchedItems);
            return SfDataGrid(
              source: dataSource,
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              onCellTap: (DataGridCellTapDetails args) {
                int index = args.rowColumnIndex.rowIndex - 1;
                if (index < 0) return;
                context.router.navigate(AVFundsRequestDetailsRoute(fundsRequest: searchedItems[index]));
              },
              columns: <GridColumn>[
                GridColumn(
                  columnName: AppStrings.id,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.id),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.title,
                  width: 250.0,
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.title, maxLines: 2, textAlign: TextAlign.center),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.category,
                  width: 180.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.category),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.status,
                  width: 180.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.status),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.requestedAmount,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.requestedAmount),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.zakatEligibility,
                  width: 120.0,
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.zakatEligibility),
                  ),
                ),
                GridColumn(
                  width: 250.0,
                  columnName: AppStrings.description,
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(AppStrings.description, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2),
                  ),
                ),
                GridColumn(
                  columnName: AppStrings.createdAt,
                  label: Container(
                    padding: const EdgeInsets.all(8),
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

class _FundsRequestsSource extends DataGridSource {
  _FundsRequestsSource(List<FundsRequest> items) {
    _items = items
        .map<DataGridRow>(
          (item) => DataGridRow(
            cells: [
              DataGridCell(columnName: AppStrings.id, value: item.id),
              DataGridCell(columnName: AppStrings.title, value: item.title),
              DataGridCell(columnName: AppStrings.category, value: item.category),
              DataGridCell<Widget>(
                columnName: AppStrings.status,
                value: Container(
                  color: item.status.color.withOpacity(0.1),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.status.value.toUpperCase(), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                ),
              ),
              DataGridCell(
                columnName: AppStrings.requestedAmount,
                value: '\$${item.requestedAmount}',
              ),
              DataGridCell(columnName: AppStrings.zakatEligibility, value: item.isZakatEligible == true ? 'Yes' : 'No'),
              DataGridCell(columnName: AppStrings.description, value: item.description),
              DataGridCell(columnName: AppStrings.createdAt, value: item.createdAt?.format()),
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
              alignment: Alignment.center,
              color: backgroundColor,
              padding: const EdgeInsets.all(8.0),
              child: Text(e.value.toString(), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
            );
    }).toList());
  }
}
