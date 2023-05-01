part of 'funds_raising_cubit.dart';

@immutable
abstract class FundsRaisingState {
  final FundsRaising? fundsRaising;
  final List<UploadingStatusManagerCubit>? uploadingManager;

  const FundsRaisingState({
    this.fundsRaising,
    this.uploadingManager,
  });

  FundsRaisingState copyWith({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  });
}

class FundsRaisingInitial extends FundsRaisingState {
  const FundsRaisingInitial({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) : super(
          fundsRaising: fundsRaising ?? const FundsRaising(),
          uploadingManager: uploadingManager,
        );

  @override
  FundsRaisingState copyWith({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) {
    return FundsRaisingInitial(
      fundsRaising: fundsRaising ?? this.fundsRaising,
      uploadingManager: uploadingManager ?? this.uploadingManager,
    );
  }
}

class FundsRaisingCreating extends FundsRaisingState {
  const FundsRaisingCreating({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) : super(
          fundsRaising: fundsRaising ?? const FundsRaising(),
          uploadingManager: uploadingManager,
        );

  @override
  FundsRaisingCreating copyWith({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) {
    return FundsRaisingCreating(
      fundsRaising: fundsRaising ?? this.fundsRaising,
      uploadingManager: uploadingManager ?? this.uploadingManager,
    );
  }
}

class FundsRaisingFailure extends FundsRaisingState {
  final String message;

  const FundsRaisingFailure({
    required this.message,
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) : super(
          fundsRaising: fundsRaising ?? const FundsRaising(),
          uploadingManager: uploadingManager,
        );

  @override
  FundsRaisingFailure copyWith({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) {
    return FundsRaisingFailure(
      message: message,
      fundsRaising: fundsRaising ?? this.fundsRaising,
      uploadingManager: uploadingManager ?? this.uploadingManager,
    );
  }
}

class FundsRaisingSuccess extends FundsRaisingState {
  final String? message;
  const FundsRaisingSuccess({
    this.message,
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) : super(
          fundsRaising: fundsRaising ?? const FundsRaising(),
          uploadingManager: uploadingManager,
        );

  @override
  FundsRaisingSuccess copyWith({
    FundsRaising? fundsRaising,
    List<UploadingStatusManagerCubit>? uploadingManager,
  }) {
    return FundsRaisingSuccess(
      fundsRaising: fundsRaising ?? this.fundsRaising,
      uploadingManager: uploadingManager ?? this.uploadingManager,
    );
  }
}
