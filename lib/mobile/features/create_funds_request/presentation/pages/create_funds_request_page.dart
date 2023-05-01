import 'dart:io';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/components/app_validator.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/mixins/input_formatters.dart';
import 'package:aitebar/core/mixins/validators.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/common/bloc/uploading_status_manager/uploading_status_manager_cubit.dart';
import 'package:aitebar/mobile/features/common/domain/uploading_model/uploading_model.dart';
import 'package:aitebar/mobile/features/create_funds_raising/presentation/widgets/image_picker_item.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:aitebar/mobile/features/create_funds_request/presentation/bloc/funds_request/funds_request_cubit.dart';
import 'package:aitebar/mobile/features/create_funds_request/presentation/bloc/request_fund_form_cubit/request_fund_form_cubit.dart';
import 'package:aitebar/mobile/features/dashboard/presentation/bloc/user_funds_requests/user_funds_requests_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class CreateFundsRequestPage extends StatelessWidget with Validators, InputFormatter {
  final FundsRequest? fundsRequest;

  CreateFundsRequestPage({super.key, this.fundsRequest});

  final _formCubit = sl<RequestFundFormCubit>();
  final List<String> categories = [
    AppStrings.education,
    AppStrings.health,
    AppStrings.ration,
    AppStrings.shortTermRelief,
    AppStrings.other,
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _fundsRequestCubit = sl<FundsRequestCubit>();

  @override
  Widget build(BuildContext context) {
    _formCubit.init(requestFund: fundsRequest);
    return Scaffold(
      appBar: AppBar(title: Text(fundsRequest == null ? AppStrings.createFundsRequest : AppStrings.updateFundsRequest)),
      body: BlocConsumer<FundsRequestCubit, FundsRequestState>(
        bloc: _fundsRequestCubit,
        listener: (context, state) {
          state.whenOrNull(
            success: (FundsRequest item) {
              if (fundsRequest == null) {
                sl<UserFundsRequestsCubit>().createFundsRequest(item);
              } else {
                sl<UserFundsRequestsCubit>().updateFundsRequest(item);
              }
              context.router.back();
              context.showToast(AppStrings.requestFundsCreatedSuccessfully);
            },
            failure: (message) {
              context.showToast(message);
            },
          );
        },
        builder: (_, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: BlocSelector<RequestFundFormCubit, RequestFundFormState, AutovalidateMode>(
              bloc: _formCubit,
              selector: (state) => state.autovalidateMode,
              builder: (context, autovalidateMode) {
                return AbsorbPointer(
                  absorbing: state == const FundsRequestState.loading(),
                  child: Form(
                    autovalidateMode: autovalidateMode,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: _formCubit.state.requestFund.title,
                          decoration: const InputDecoration(hintText: AppStrings.title),
                          onChanged: _formCubit.onChangedTitle,
                          validator: validateTitle,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue:
                              _formCubit.state.requestFund.requestedAmount > 0 ? _formCubit.state.requestFund.requestedAmount.toString() : null,
                          decoration: const InputDecoration(hintText: AppStrings.requireAmount),
                          onChanged: _formCubit.onChangedRequestedAmount,
                          validator: validateAmount,
                          inputFormatters: [decimalFormatter],
                        ),
                        const SizedBox(height: 12.0),
                        BlocSelector<RequestFundFormCubit, RequestFundFormState, String>(
                          bloc: _formCubit,
                          selector: (state) => state.requestFund.category,
                          builder: (context, category) {
                            return TextFormField(
                              initialValue: _formCubit.state.requestFund.category,
                              key: ValueKey(category),
                              readOnly: true,
                              validator: validateCategory,
                              decoration: const InputDecoration(hintText: AppStrings.chooseCategory),
                              // readOnly: true,
                            );
                          },
                        ),
                        const SizedBox(height: 12.0),
                        Wrap(
                          children: categories.map((e) {
                            return Card(
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(8.0),
                                    onTap: () {
                                      _formCubit.onChangedCategory(e);
                                    },
                                    child: Padding(padding: const EdgeInsets.all(8.0), child: Text(e))));
                          }).toList(),
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.requestFund.description,
                          decoration: const InputDecoration(
                            hintText: AppStrings.description,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                          onChanged: _formCubit.onChangedDescription,
                          maxLines: 5,
                          validator: validateDescription,
                        ),
                        const SizedBox(height: 12.0),
                        const Text(AppStrings.cnicImages),
                        const SizedBox(height: 12.0),
                        BlocSelector<RequestFundFormCubit, RequestFundFormState, List<UploadingStatusManagerCubit>>(
                            bloc: _formCubit,
                            selector: (state) => [...?state.cnicUploadingManager],
                            builder: (context, List<UploadingStatusManagerCubit> uploadingManager) {
                              return AppValidator(
                                validator: (_) {
                                  String? m = uploadingManager.isEmpty && _formCubit.state.requestFund.cnicImages.isEmpty
                                      ? AppStrings.pleaseAddSomeImages
                                      : null;
                                  return m;
                                },
                                child: Wrap(spacing: 8.0, runSpacing: 8.0, children: [
                                  ImagePickerItem(onTap: _formCubit.pickCnicImages),
                                  ...uploadingManager
                                      .map(
                                        (uploader) => BlocSelector<UploadingStatusManagerCubit, FileUploadingStatusManagerState, UploadingModel?>(
                                          bloc: uploader,
                                          selector: (state) => state.uploadingFile,
                                          builder: (context, uploadingFiles) {
                                            UploadingModel? uploadingModel = uploader.state.uploadingFile;
                                            if (uploadingModel?.file != null) {
                                              return _ImageViewerItem(
                                                image: uploadingModel?.file,
                                                progress: uploader.state.uploadingFile?.progress,
                                                total: uploader.state.uploadingFile?.total,
                                                onRemove: () => _formCubit.onRemoveCNICImage(uploadingModel!.file),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      )
                                      .toList(),
                                ]),
                              );
                            }),
                        const SizedBox(height: 12.0),
                        BlocSelector<RequestFundFormCubit, RequestFundFormState, List<String>>(
                            bloc: _formCubit,
                            selector: (state) => [...state.requestFund.cnicImages],
                            builder: (context, List<dynamic> images) {
                              return Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: images
                                    .map(
                                      (image) => _ImageViewerItem(
                                        image: image,
                                        onRemove: () => image is XFile ? _formCubit.onRemoveCNICImage(image) : _formCubit.onRemoveCNICImageUrl(image),
                                      ),
                                    )
                                    .toList(),
                              );
                            }),

// bills

                        const SizedBox(height: 12.0),
                        const Text(AppStrings.electricityOrWaterBill),
                        const SizedBox(height: 12.0),
                        BlocSelector<RequestFundFormCubit, RequestFundFormState, List<UploadingStatusManagerCubit>>(
                            bloc: _formCubit,
                            selector: (state) => [...?state.billUploadingManager],
                            builder: (context, List<UploadingStatusManagerCubit> uploadingManager) {
                              return AppValidator(
                                validator: (_) {
                                  String? m = uploadingManager.isEmpty && _formCubit.state.requestFund.billImages.isEmpty
                                      ? AppStrings.pleaseAddSomeImages
                                      : null;
                                  return m;
                                },
                                child: Wrap(spacing: 8.0, runSpacing: 8.0, children: [
                                  ImagePickerItem(onTap: _formCubit.pickBillImages),
                                  ...uploadingManager
                                      .map(
                                        (uploader) => BlocSelector<UploadingStatusManagerCubit, FileUploadingStatusManagerState, UploadingModel?>(
                                          bloc: uploader,
                                          selector: (state) => state.uploadingFile,
                                          builder: (context, uploadingFiles) {
                                            UploadingModel? uploadingModel = uploader.state.uploadingFile;
                                            if (uploadingModel?.file != null) {
                                              return _ImageViewerItem(
                                                image: uploadingModel?.file,
                                                progress: uploader.state.uploadingFile?.progress,
                                                total: uploader.state.uploadingFile?.total,
                                                onRemove: () => _formCubit.onRemoveBillImage(uploadingModel!.file),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      )
                                      .toList(),
                                ]),
                              );
                            }),
                        const SizedBox(height: 12.0),
                        BlocSelector<RequestFundFormCubit, RequestFundFormState, List<String>>(
                            bloc: _formCubit,
                            selector: (state) => [...state.requestFund.billImages],
                            builder: (context, List<dynamic> images) {
                              return Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: images
                                    .map(
                                      (image) => _ImageViewerItem(
                                        image: image,
                                        onRemove: () => _formCubit.onRemoveBillImageUrl(image),
                                      ),
                                    )
                                    .toList(),
                              );
                            }),
                        const SizedBox(height: 12.0),
                        const Text(AppStrings.accountDetails),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.requestFund.accountTitle,
                          decoration: const InputDecoration(hintText: AppStrings.accountTitle),
                          onChanged: _formCubit.onChangedAccountTitle,
                          validator: validateAccountTitle,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.requestFund.bankName,
                          decoration: const InputDecoration(hintText: AppStrings.bankName),
                          onChanged: _formCubit.onChangedBankName,
                          validator: validateBankName,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.requestFund.accountNumber,
                          decoration: const InputDecoration(hintText: AppStrings.accountNumber),
                          onChanged: _formCubit.onChangedAccountNumber,
                          validator: validateAccountNumber,
                        ),
                        const SizedBox(height: 24.0),
                        BlocSelector<RequestFundFormCubit, RequestFundFormState, bool>(
                          bloc: _formCubit,
                          selector: (state) => state.requestFund.isZakatEligible ?? false,
                          builder: (context, state) {
                            return CheckboxListTile(
                              value: state,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: _formCubit.onChangedZakatEligible,
                              title: const Text(AppStrings.zakatEligible),
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),
                        BlocSelector<FundsRequestCubit, FundsRequestState, bool>(
                            bloc: _fundsRequestCubit,
                            selector: (state) => state == const FundsRequestState.loading(),
                            builder: (context, bool isLoading) {
                              return AppButton.gradient(
                                isProcessing: isLoading,
                                onPressed: _attemptToCreatePost,
                                child: const Text(AppStrings.createFundsRequest),
                              );
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _attemptToCreatePost() {
    if (_formKey.currentState?.validate() ?? false) {
      if (fundsRequest == null) {
        _fundsRequestCubit.createPost(
          fundsRequest: _formCubit.state.requestFund,
          cnicUploadingManager: _formCubit.state.cnicUploadingManager ?? [],
          billUploadingManager: _formCubit.state.billUploadingManager ?? [],
        );
      } else {
        _fundsRequestCubit.updatePost(
          fundsRequest: _formCubit.state.requestFund,
          cnicUploadingManager: _formCubit.state.cnicUploadingManager ?? [],
          billUploadingManager: _formCubit.state.billUploadingManager ?? [],
        );
      }
    } else {
      _formCubit.setAutovalidateMode(AutovalidateMode.always);
    }
  }
}

class _ImageViewerItem extends StatelessWidget {
  final VoidCallback? onRemove;
  final dynamic image;
  final num? progress;
  final num? total;

  const _ImageViewerItem({
    Key? key,
    this.onRemove,
    this.progress,
    this.total,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: context.primary.withOpacity(0.2),
      child: Stack(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: image is XFile
                ? AppImage.file(
                    file: File(image.path),
                    fit: BoxFit.fill,
                    borderRadius: BorderRadius.circular(8.0),
                  )
                : AppImage.network(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
          ),
          Positioned(
            right: 0.0,
            child: InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: context.error.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(LineIcons.times, size: 12.0, color: context.onError),
              ),
            ),
          ),
          if (progress != null && total != null)
            Positioned.fill(
              child: Center(
                child: Container(
                  height: 36.0,
                  width: 36.0,
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: progress == total ? context.onPrimary.withOpacity(0.7) : null,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: progress == total
                      ? Icon(
                          LineIcons.check,
                          size: 24.0,
                          color: context.primaryColor,
                        )
                      : CircularProgressIndicator(
                          strokeWidth: 3.0,
                          value: progress! / total!,
                          valueColor: AlwaysStoppedAnimation(context.primary),
                          backgroundColor: context.primary.withOpacity(0.2),
                        ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
