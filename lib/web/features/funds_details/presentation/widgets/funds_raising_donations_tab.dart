import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/funds_details/domain/models/funds_raising_donations/funds_raising_donation.dart';
import 'package:aitebar/web/features/funds_details/presentation/bloc/funds_raising_donations/funds_raising_donations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FundsRaisingDonationsTab extends StatelessWidget {
  final FundsRaising fundsRaising;

  FundsRaisingDonationsTab({required this.fundsRaising, Key? key}) : super(key: key);
  final FundsRaisingDonationsCubit _fundsRaisingDonationsCubit = sl<FundsRaisingDonationsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundsRaisingDonationsCubit, FundsRaisingDonationsState>(
      bloc: _fundsRaisingDonationsCubit,
      builder: (context, state) {
        _DonationsSource dataSource = _DonationsSource(state.items);
        return SfDataGrid(
          source: dataSource,
          columnWidthMode: context.isMobile ? ColumnWidthMode.fitByCellValue : ColumnWidthMode.fill,
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
              columnName: AppStrings.amount,
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(AppStrings.amount, maxLines: 2, textAlign: TextAlign.center),
              ),
            ),
            GridColumn(
              columnName: AppStrings.fundsRaisingId,
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(AppStrings.fundsRaisingId, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2),
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
  }
}

class _DonationsSource extends DataGridSource {
  _DonationsSource(List<FundsRaisingDonation> items) {
    _items = items
        .map<DataGridRow>(
          (item) => DataGridRow(
            cells: [
              DataGridCell(columnName: AppStrings.id, value: item.id),
              DataGridCell(columnName: AppStrings.amount, value: item.amount),
              DataGridCell(columnName: AppStrings.fundsRaisingId, value: item.fundsRaisingId),
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
      return Container(
        alignment: Alignment.center,
        color: backgroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString(), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
      );
    }).toList());
  }
}
