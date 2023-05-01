part of 'create_post_form_cubit.dart';

abstract class CreatePostFormState {
  final AutovalidateMode autovalidateMode;
  final FundsRaising fundsRaising;
  List<UploadingStatusManagerCubit>? uploadingManager;


  CreatePostFormState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.fundsRaising = const FundsRaising(),
    this.uploadingManager,
  });

  CreatePostFormState copyWith({
    AutovalidateMode? autovalidateMode,
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  });
}

class CreatePostFormUpdate extends CreatePostFormState {
  CreatePostFormUpdate({
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) : super(
          autovalidateMode: autovalidateMode,
          fundsRaising: fundsRaising ?? const FundsRaising(),
          uploadingManager: uploadingManager,
        );

  @override
  CreatePostFormState copyWith({
    AutovalidateMode? autovalidateMode,
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) {
    return CreatePostFormUpdate(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      fundsRaising: fundsRaising ?? this.fundsRaising,
      uploadingManager: uploadingManager ?? this.uploadingManager,
    );
  }
}