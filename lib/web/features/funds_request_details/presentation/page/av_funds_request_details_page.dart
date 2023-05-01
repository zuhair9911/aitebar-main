import 'dart:math';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/extensions/datetime_extension.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:aitebar/web/features/dashboard/presentation/bloc/funds_requests/funds_requests_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';

import '../bloc/manage_funds_request/manage_funds_request_cubit.dart';

@RoutePage()
class AVFundsRequestDetailsPage extends StatelessWidget {
  final FundsRequest fundsRequest;
  final bool isAdmin;

  AVFundsRequestDetailsPage({required this.fundsRequest, this.isAdmin = true, Key? key}) : super(key: key);
  final _StatusTypeCubit _statusTypeCubit = _StatusTypeCubit();

  final _fundsRequestCubit = sl<FundsRequestsCubit>();

  final _manageFundRequest = sl<ManageFundsRequestCubit>();

  @override
  Widget build(BuildContext context) {
    _statusTypeCubit
      ..changeStatus(fundsRequest.status)
      ..updateMessage(fundsRequest.statusMessage);

    return Scaffold(
      appBar: AppBar(
        title: Text(fundsRequest.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: context.isDesktop ? min(context.width * 0.8, 1200.0) : context.width,
          child: SingleChildScrollView(
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
                      fundsRequest.cnicImages.length + fundsRequest.billImages.length,
                      (index) {
                        List<String> images = [...fundsRequest.cnicImages, ...fundsRequest.billImages];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: AppImage.network(
                            imageUrl: images[index],
                            width: max(150.0, context.width * 0.15),
                            height: max(150.0, context.width * 0.15),
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
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
                          Text(fundsRequest.title, style: context.titleLarge),
                          const SizedBox(height: 12.0),
                          Container(
                            height: 4.0,
                            decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(8.0)),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            fundsRequest.description,
                            style: context.labelLarge,
                          ),
                          const SizedBox(height: 12.0),
                          const Divider(color: Colors.grey),
                          ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            title: Text(AppStrings.requestedAmount, style: context.titleSmall),
                            trailing: Text('\$${fundsRequest.requestedAmount}', style: context.titleSmall),
                          ),
                          ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            title: Text(AppStrings.category, style: context.titleSmall),
                            trailing: Text(fundsRequest.category, style: context.titleSmall),
                          ),
                          ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            title: Text(AppStrings.createdAt, style: context.titleSmall),
                            trailing: Text('${fundsRequest.createdAt?.format()}', style: context.titleSmall),
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
                            trailing: Text(fundsRequest.accountTitle, style: context.titleSmall),
                          ),
                          ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            title: Text(AppStrings.bankName, style: context.titleSmall),
                            trailing: Text(fundsRequest.bankName, style: context.titleSmall),
                          ),
                          ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            title: Text(AppStrings.accountNumber, style: context.titleSmall),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(fundsRequest.accountNumber, style: context.titleSmall),
                                const SizedBox(width: 12.0),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: fundsRequest.accountNumber));
                                    context.showToast(AppStrings.copied);
                                  },
                                  icon: const Icon(LineIcons.copyAlt),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16.0),
                          // Card(
                          //   elevation: 0.0,
                          //   color: context.primary.withOpacity(0.2),
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          //     child: Row(
                          //       children: [
                          //         const Text(AppStrings.referenceId),
                          //         const Spacer(),
                          //         Text(fundsRaising.referenceId ?? fundsRaising.id.referenceId),
                          //         const SizedBox(width: 12.0),
                          //         IconButton(
                          //           onPressed: () {
                          //             Clipboard.setData(ClipboardData(text: fundsRaising.referenceId ?? fundsRaising.id.referenceId));
                          //             context.showToast(AppStrings.copied);
                          //           },
                          //           icon: const Icon(LineIcons.copyAlt),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                                          if (isAdmin)
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
                                      enabled: isAdmin,
                                      decoration:
                                          const InputDecoration(hintText: AppStrings.describeYourReason, contentPadding: EdgeInsets.all(16.0)),
                                      maxLines: 4,
                                      onChanged: _statusTypeCubit.updateMessage,
                                    ),
                                  const SizedBox(height: 16.0),
                                ],
                              );
                            },
                          ),
                          if (isAdmin)
                            BlocBuilder<ManageFundsRequestCubit, ManageFundsRequestState>(
                              bloc: _manageFundRequest,
                              builder: (context, state) {
                                state.whenOrNull(
                                  success: (updatedItem) {
                                    _fundsRequestCubit.updateFundsRequest(fundsRequest: updatedItem);
                                    context.showToast(AppStrings.fundsRaisingCreatedSuccessfully);
                                    context.router.back();
                                  },
                                );
                                return BlocBuilder<_StatusTypeCubit, _StatusTypeState>(
                                  bloc: _statusTypeCubit,
                                  builder: (context, statusTypeState) {
                                    if (statusTypeState.statusType == fundsRequest.status) {
                                      return const SizedBox.shrink();
                                    }
                                    return AppButton.primary(
                                        isProcessing: state == const ManageFundsRequestState.loading(),
                                        onPressed: () {
                                          _manageFundRequest.updateFundsRaising(
                                              item: fundsRequest.copyWith(
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
                    ),

                  ],
                ),
                const SizedBox(height: 12.0),
                const Divider(color: Colors.grey),
              ],
            ),
          ),
        ),
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
