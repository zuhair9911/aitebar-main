import 'dart:math';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/core/extensions/string_extension.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/funds_raising/funds_raising_cubit.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/manage_funds_raising/manage_funds_raising_cubit.dart';
import 'package:aitebar/web/features/funds_details/presentation/bloc/funds_raising_donations/funds_raising_donations_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';

class FundsRaisingDetailsTab extends StatelessWidget {
  final FundsRaising fundsRaising;
  final TabController tabController;

  FundsRaisingDetailsTab({
    super.key,
    required this.fundsRaising,
    required this.tabController,
  });

  final _fundRaisingCubit = sl<FundsRaisingCubit>();

  final _manageFundsRaising = sl<ManageFundsRaisingCubit>();
  final _fundsRaisingDonations = sl<FundsRaisingDonationsCubit>();
  final _StatusTypeCubit _statusTypeCubit = _StatusTypeCubit();

  @override
  Widget build(BuildContext context) {
    _statusTypeCubit
      ..changeStatus(fundsRaising.status)
      ..updateMessage(fundsRaising.statusMessage);
    _fundsRaisingDonations.fetchFundsRaising(fundsRaisingId: fundsRaising.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: max(150.0, context.width * 0.15),
            child: ListView(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                fundsRaising.images.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: AppImage.network(
                    imageUrl: fundsRaising.images[index],
                    width: max(150.0, context.width * 0.15),
                    height: max(150.0, context.width * 0.15),
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8.0),
          StaggeredGrid.count(
            crossAxisCount: context.isMobile || context.isSmallTablet ? 1 : 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(fundsRaising.title, style: context.titleLarge),
                    const SizedBox(height: 12.0),
                    Container(
                      height: 4.0,
                      decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(8.0)),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      fundsRaising.description,
                      style: context.labelLarge,
                    ),
                    const SizedBox(height: 12.0),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: AppImage.network(
                              imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fundsRaising.email,
                                  style: context.labelLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(fundsRaising.contactNumber, style: context.labelLarge),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.raised, style: context.titleSmall),
                      trailing: Text('\$${fundsRaising.raisedAmount}', style: context.titleSmall),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.requireAmount, style: context.titleSmall),
                      trailing: Text('\$${fundsRaising.requireAmount}', style: context.titleSmall),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.category, style: context.titleSmall),
                      trailing: Text(fundsRaising.category, style: context.titleSmall),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.address, style: context.titleSmall),
                      trailing: Text(fundsRaising.address, style: context.titleSmall),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.createdAt, style: context.titleSmall),
                      trailing: Text('${fundsRaising.createdAt?.format()}', style: context.titleSmall),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                width: double.infinity,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.accountTitle, style: context.titleSmall),
                      trailing: Text(fundsRaising.accountTitle, style: context.titleSmall),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.bankName, style: context.titleSmall),
                      trailing: Text(fundsRaising.bankName, style: context.titleSmall),
                    ),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(AppStrings.accountNumber, style: context.titleSmall),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(fundsRaising.accountNumber, style: context.titleSmall),
                          const SizedBox(width: 12.0),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: fundsRaising.accountNumber));
                              context.showToast(AppStrings.copied);
                            },
                            icon: const Icon(LineIcons.copyAlt),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      height: 40.0,
                      child: Row(
                        children: [
                          Expanded(child: AppButton.gradient(onPressed: () {}, child: const Text(AppStrings.share))),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: AppButton.gradient(
                              onPressed: () {
                                tabController.animateTo(1);
                              },
                              child: const Text(AppStrings.viewDonations),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      elevation: 0.0,
                      color: context.primary.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        child: Row(
                          children: [
                            const Text(AppStrings.referenceId),
                            const Spacer(),
                            Text(fundsRaising.referenceId ?? fundsRaising.id.referenceId),
                            const SizedBox(width: 12.0),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: fundsRaising.referenceId ?? fundsRaising.id.referenceId));
                                context.showToast(AppStrings.copied);
                              },
                              icon: const Icon(LineIcons.copyAlt),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    BlocBuilder<_StatusTypeCubit, _StatusTypeState>(
                      bloc: _statusTypeCubit,
                      builder: (context, state) {
                        return Column(
                          children: [
                            Card(
                              color: state.statusType.color.withOpacity(0.2),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                child: Row(
                                  children: [
                                    Text('${AppStrings.status}: ${state.statusType.value.toUpperCase()}'),
                                    const Spacer(),
                                    PopupMenuButton<StatusType>(
                                      iconSize: 24.0,
                                      icon: const Icon(LineIcons.angleDown),
                                      initialValue: state.statusType,
                                      // Callback that sets the selected popup menu item.
                                      onSelected: (StatusType type) {
                                        _statusTypeCubit.changeStatus(type);
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return StatusType.values
                                            .where((s) => s != StatusType.delete)
                                            .map<PopupMenuItem<StatusType>>((StatusType value) {
                                          return PopupMenuItem<StatusType>(
                                            value: value,
                                            child: Text(value.value.toUpperCase()),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            if (state.statusType == StatusType.rejected)
                              TextFormField(
                                initialValue: state.message,
                                decoration: const InputDecoration(hintText: AppStrings.describeYourReason, contentPadding: EdgeInsets.all(16.0)),
                                maxLines: 4,
                                onChanged: _statusTypeCubit.updateMessage,
                              ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<ManageFundsRaisingCubit, ManageFundsRaisingState>(
                bloc: _manageFundsRaising,
                builder: (context, state) {
                  state.whenOrNull(
                    success: (updatedItem) {
                      _fundRaisingCubit.updateFundsRaising(fundsRaising: updatedItem);
                      context.showToast(AppStrings.fundsRaisingCreatedSuccessfully);
                      context.router.back();
                    },
                  );
                  return BlocBuilder<_StatusTypeCubit, _StatusTypeState>(
                    bloc: _statusTypeCubit,
                    builder: (context, statusTypeState) {
                      if (statusTypeState.statusType == fundsRaising.status) {
                        return const SizedBox.shrink();
                      }
                      return AppButton.primary(
                          isProcessing: state == const ManageFundsRaisingState.loading(),
                          onPressed: () {
                            _manageFundsRaising.updateFundsRaising(
                                fundsRaising: fundsRaising.copyWith(
                              status: statusTypeState.statusType,
                              statusMessage: statusTypeState.message,
                            ));
                          },
                          child: Text(AppStrings.updateFundsRequest.toUpperCase()));
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

class _StatusTypeCubit extends Cubit<_StatusTypeState> {
  _StatusTypeCubit() : super(const _StatusTypeUpdateState());

  void changeStatus(StatusType statusType) {
    if (statusType != StatusType.rejected) {
      emit(state.copyWith(statusType: statusType, message: null));
    } else {
      emit(state.copyWith(statusType: statusType));
    }
  }

  void updateMessage(String? message) {
    emit(state.copyWith(message: message));
  }
}

abstract class _StatusTypeState {
  final StatusType statusType;
  final String? message;

  const _StatusTypeState({
    this.statusType = StatusType.pending,
    this.message,
  });

  _StatusTypeState copyWith({
    StatusType? statusType,
    String? message,
  });
}

class _StatusTypeUpdateState extends _StatusTypeState {
  const _StatusTypeUpdateState({
    StatusType statusType = StatusType.pending,
    String? message,
  }) : super(statusType: statusType, message: message);

  @override
  _StatusTypeUpdateState copyWith({
    StatusType? statusType,
    String? message,
  }) {
    return _StatusTypeUpdateState(
      statusType: statusType ?? this.statusType,
      message: message ?? this.message,
    );
  }
}
