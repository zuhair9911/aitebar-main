import 'dart:io';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/app_image.dart';
import 'package:aitebar/core/components/app_validator.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/mixins/input_formatters.dart';
import 'package:aitebar/core/mixins/validators.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/common/bloc/uploading_status_manager/uploading_status_manager_cubit.dart';
import 'package:aitebar/mobile/features/common/domain/uploading_model/uploading_model.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/mobile/features/create_funds_raising/presentation/blocs/create_post_form_cubit/create_post_form_cubit.dart';
import 'package:aitebar/mobile/features/create_funds_raising/presentation/blocs/funds_raising/funds_raising_cubit.dart';
import 'package:aitebar/mobile/features/create_funds_raising/presentation/widgets/image_picker_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class CreateFundsRaisingPage extends StatelessWidget with Validators, InputFormatter {
  final FundsRaising? fundsRaising;

  CreateFundsRaisingPage({this.fundsRaising, Key? key}) : super(key: key);
  final _formCubit = sl<CreatePostFormCubit>();
  final List<String> categories = [
    AppStrings.education,
    AppStrings.health,
    AppStrings.environment,
    AppStrings.animal,
    AppStrings.disaster,
    AppStrings.other,
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _fundsRaisingCubit = sl<FundsRaisingCubit>();

  @override
  Widget build(BuildContext context) {
    if (fundsRaising != null) {
      _formCubit.init(fundsRaising!);
    }
    return Scaffold(
      appBar: AppBar(title: fundsRaising == null ? const Text(AppStrings.createFundsRaising) : const Text(AppStrings.editFundsRaising)),
      body: BlocConsumer<FundsRaisingCubit, FundsRaisingState>(
        bloc: _fundsRaisingCubit,
        listener: (context, state) {
          if (state is FundsRaisingSuccess) {
            context.router.back();
            context.showToast(state.message ?? AppStrings.fundsRaisingCreatedSuccessfully);
          } else if (state is FundsRaisingFailure) {
            context.showToast(state.message);
          }
        },
        builder: (_, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: BlocSelector<CreatePostFormCubit, CreatePostFormState, AutovalidateMode>(
              bloc: _formCubit,
              selector: (state) => state.autovalidateMode,
              builder: (context, autovalidateMode) {
                return AbsorbPointer(
                  absorbing: state is FundsRaisingCreating,
                  child: Form(
                    autovalidateMode: autovalidateMode,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocSelector<CreatePostFormCubit, CreatePostFormState, List<UploadingStatusManagerCubit>>(
                            bloc: _formCubit,
                            selector: (state) => [...?state.uploadingManager],
                            builder: (context, List<UploadingStatusManagerCubit> uploadingManager) {
                              return AppValidator(
                                validator: (_) {
                                  String? m = uploadingManager.isEmpty && _formCubit.state.fundsRaising.images.isEmpty
                                      ? AppStrings.pleaseAddSomeImages
                                      : null;
                                  return m;
                                },
                                child: Wrap(spacing: 8.0, runSpacing: 8.0, children: [
                                  ImagePickerItem(onTap: _formCubit.pickImages),
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
                                                onRemove: () => _formCubit.onRemoveFile(uploadingModel!.file),
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
                        // URL of the images
                        BlocSelector<CreatePostFormCubit, CreatePostFormState, List<String>>(
                            bloc: _formCubit,
                            selector: (state) => [...state.fundsRaising.images],
                            builder: (context, List<dynamic> images) {
                              return Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: images
                                    .map(
                                      (image) => _ImageViewerItem(
                                        image: image,
                                        onRemove: () => _formCubit.onRemoveImageUrl(image),
                                      ),
                                    )
                                    .toList(),
                              );
                            }),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.title,
                          decoration: const InputDecoration(hintText: AppStrings.title),
                          onChanged: _formCubit.onChangedTitle,
                          validator: validateTitle,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue:
                              _formCubit.state.fundsRaising.requireAmount > 0 ? _formCubit.state.fundsRaising.requireAmount.toString() : null,
                          decoration: const InputDecoration(hintText: AppStrings.requireAmount),
                          onChanged: _formCubit.onChangedRequireAmount,
                          validator: validateAmount,
                          inputFormatters: [decimalFormatter],
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.address,
                          decoration: const InputDecoration(hintText: AppStrings.address),
                          onChanged: _formCubit.onChangedAddress,
                          validator: validateAddress,
                        ),
                        const SizedBox(height: 12.0),
                        BlocSelector<CreatePostFormCubit, CreatePostFormState, String>(
                          bloc: _formCubit,
                          selector: (state) => state.fundsRaising.category,
                          builder: (context, category) {
                            return TextFormField(
                              initialValue: _formCubit.state.fundsRaising.category,
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
                          initialValue: _formCubit.state.fundsRaising.email,
                          decoration: const InputDecoration(hintText: AppStrings.email),
                          onChanged: _formCubit.onChangedEmail,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.contactNumber,
                          decoration: const InputDecoration(hintText: AppStrings.contactNumber),
                          onChanged: _formCubit.onChangedContactNumber,
                          validator: validateContactNumber,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.description,
                          decoration: const InputDecoration(
                            hintText: AppStrings.description,
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                          onChanged: _formCubit.onChangedDescription,
                          maxLines: 5,
                          validator: validateDescription,
                        ),
                        const SizedBox(height: 12.0),
                        const Text(AppStrings.accountDetails),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.accountTitle,
                          decoration: const InputDecoration(hintText: AppStrings.accountTitle),
                          onChanged: _formCubit.onChangedAccountTitle,
                          validator: validateAccountTitle,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.bankName,
                          decoration: const InputDecoration(hintText: AppStrings.bankName),
                          onChanged: _formCubit.onChangedBankName,
                          validator: validateBankName,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          initialValue: _formCubit.state.fundsRaising.accountNumber,
                          decoration: const InputDecoration(hintText: AppStrings.accountNumber),
                          onChanged: _formCubit.onChangedAccountNumber,
                          validator: validateAccountNumber,
                        ),
                        const SizedBox(height: 24.0),
                        BlocSelector<FundsRaisingCubit, FundsRaisingState, FundsRaisingCreating?>(
                            bloc: _fundsRaisingCubit,
                            selector: (state) => state is FundsRaisingCreating ? state : null,
                            builder: (context, FundsRaisingCreating? state) {
                              return AppButton.gradient(
                                isProcessing: state != null,
                                onPressed: _attemptToCreatePost,
                                child: const Text(AppStrings.createFundsRaising),
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
      if (fundsRaising == null) {
        _fundsRaisingCubit.createPost(
          fundsRaising: _formCubit.state.fundsRaising,
          uploadingManager: _formCubit.state.uploadingManager ?? [],
        );
      } else {
        _fundsRaisingCubit.updatePost(
          fundsRaising: _formCubit.state.fundsRaising.copyWith(status: StatusType.pending),
          uploadingManager: _formCubit.state.uploadingManager ?? [],
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
                ? AppImage.file(file: File(image.path), fit: BoxFit.fill, borderRadius: BorderRadius.circular(8.0))
                : AppImage.network(imageUrl: image, fit: BoxFit.fill, borderRadius: BorderRadius.circular(8.0)),
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
                      ? Icon(LineIcons.check, size: 24.0, color: context.primaryColor)
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
