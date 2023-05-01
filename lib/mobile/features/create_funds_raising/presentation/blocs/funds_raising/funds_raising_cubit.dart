import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/common/bloc/uploading_status_manager/uploading_status_manager_cubit.dart';
import 'package:aitebar/mobile/features/common/domain/cloud_storage_facade.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'funds_raising_state.dart';

@Injectable()
class FundsRaisingCubit extends Cubit<FundsRaisingState> {
  final ICloudStorageFacade _storageFacade = sl<ICloudStorageFacade>();
  final _fundsRaisingFacade = sl<IFundsRaisingFacade>();
  final _log = getLogger('FundsRaisingCubit');

  FundsRaisingCubit() : super(const FundsRaisingInitial());

  Future<void> createPost({
    required FundsRaising fundsRaising,
    List<UploadingStatusManagerCubit> uploadingManager = const [],
  }) async {
    try {
      emit(FundsRaisingCreating(fundsRaising: fundsRaising, uploadingManager: uploadingManager));
      List<String> newImage = [];
      for (UploadingStatusManagerCubit manager in uploadingManager) {
        String url = await _storageFacade.uploadFile(
            file: manager.state.uploadingFile!.file,
            uploadingProgress: (progress, total) {
              manager.updateProgress(progress: progress, total: total);
            });
        newImage.add(url);
        manager.updateUrl(url: url);
      }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      fundsRaising = fundsRaising.copyWith(images: [
        ...?state.fundsRaising?.images,
        ...newImage,
      ], uid: uid);
      await _fundsRaisingFacade.createFundsRaising(fundsRaising: fundsRaising);
      emit(FundsRaisingSuccess(message : AppStrings.fundsRaisingCreatedSuccessfully,fundsRaising: fundsRaising, uploadingManager: uploadingManager));
    } on FirebaseException catch (e, stackTrace) {
      _log.e('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRaisingFailure(message: e.message ?? AppStrings.somethingWentWrong, fundsRaising: fundsRaising, uploadingManager: uploadingManager));
    } catch (e, stackTrace) {
      _log.e('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRaisingFailure(message: e.toString(), fundsRaising: fundsRaising, uploadingManager: uploadingManager));
    }
  }

  Future<void> updatePost({required FundsRaising fundsRaising, required List<UploadingStatusManagerCubit> uploadingManager}) async {
    try {
      emit(FundsRaisingCreating(fundsRaising: fundsRaising, uploadingManager: uploadingManager));
      List<String> newImage = [];
      for (UploadingStatusManagerCubit manager in uploadingManager) {
        String url = await _storageFacade.uploadFile(
            file: manager.state.uploadingFile!.file,
            uploadingProgress: (progress, total) {
              manager.updateProgress(progress: progress, total: total);
            });
        newImage.add(url);
        manager.updateUrl(url: url);
      }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      fundsRaising = fundsRaising.copyWith(images: [
        ...?state.fundsRaising?.images,
        ...newImage,
      ], uid: uid);
      await _fundsRaisingFacade.updateFundsRaising(fundsRaising: fundsRaising);
      emit(FundsRaisingSuccess(message : AppStrings.updateFundRaisingSuccessfully ,fundsRaising: fundsRaising, uploadingManager: uploadingManager));
    } on FirebaseException catch (e, stackTrace) {
      _log.e('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRaisingFailure(message: e.message ?? AppStrings.somethingWentWrong, fundsRaising: fundsRaising, uploadingManager: uploadingManager));
    } catch (e, stackTrace) {
      _log.e('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRaisingFailure(message: e.toString(), fundsRaising: fundsRaising, uploadingManager: uploadingManager));
    }
  }
}
