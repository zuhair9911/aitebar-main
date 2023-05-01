import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/extensions/firebase_exception_extension.dart';
import 'package:aitebar/mobile/features/common/bloc/uploading_status_manager/uploading_status_manager_cubit.dart';
import 'package:aitebar/mobile/features/common/domain/cloud_storage_facade.dart';
import 'package:aitebar/core/services/domain/funds_request_facade.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'funds_request_cubit.freezed.dart';

part 'funds_request_state.dart';

@Injectable()
class FundsRequestCubit extends Cubit<FundsRequestState> {
  final ICloudStorageFacade _storageFacade;
  final IFundsRequestFacade _fundsRaisingFacade;

  FundsRequestCubit(
    this._storageFacade,
    this._fundsRaisingFacade,
  ) : super(const FundsRequestState.initial());

  Future<void> createPost({
    required FundsRequest fundsRequest,
    List<UploadingStatusManagerCubit> cnicUploadingManager = const [],
    List<UploadingStatusManagerCubit> billUploadingManager = const [],
  }) async {
    try {
      emit(const FundsRequestState.loading());
      List<String> cnicNewImage = [];
      for (UploadingStatusManagerCubit manager in cnicUploadingManager) {
        String url = await _storageFacade.uploadFile(
            path: FirebaseKey.cnicImages,
            file: manager.state.uploadingFile!.file,
            uploadingProgress: (progress, total) {
              manager.updateProgress(progress: progress, total: total);
            });
        cnicNewImage.add(url);
        manager.updateUrl(url: url);
      }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      fundsRequest = fundsRequest.copyWith(
          cnicImages: [
            ...cnicNewImage,
            ...fundsRequest.cnicImages,
          ].take(2).toList(),
          uid: uid);

      List<String> billNewImage = [];
      for (UploadingStatusManagerCubit manager in billUploadingManager) {
        String url = await _storageFacade.uploadFile(
            path: FirebaseKey.billImages,
            file: manager.state.uploadingFile!.file,
            uploadingProgress: (progress, total) {
              manager.updateProgress(progress: progress, total: total);
            });
        billNewImage.add(url);
        manager.updateUrl(url: url);
      }
      fundsRequest = fundsRequest.copyWith(
          billImages: [
        ...billNewImage,
        ...fundsRequest.billImages,
      ].take(2).toList());

      await _fundsRaisingFacade.createFundsRequest(fundsRequest: fundsRequest);
      emit(FundsRequestState.success(fundsRequest: fundsRequest));
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRequestState.failure(message: e.toFirebaseMessage()));
    } catch (e, stackTrace) {
      debugPrint('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRequestState.failure(message: e.toString()));
    }
  }

  Future<void> updatePost({
    required FundsRequest fundsRequest,
    List<UploadingStatusManagerCubit> cnicUploadingManager = const [],
    List<UploadingStatusManagerCubit> billUploadingManager = const [],
  }) async {
    try {
      emit(const FundsRequestState.loading());
      List<String> cnicNewImage = [];
      for (UploadingStatusManagerCubit manager in cnicUploadingManager) {
        String url = await _storageFacade.uploadFile(
            path: FirebaseKey.cnicImages,
            file: manager.state.uploadingFile!.file,
            uploadingProgress: (progress, total) {
              manager.updateProgress(progress: progress, total: total);
            });
        cnicNewImage.add(url);
        manager.updateUrl(url: url);
      }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      fundsRequest = fundsRequest.copyWith(
          cnicImages: [
            ...cnicNewImage,
            ...fundsRequest.cnicImages,
          ].take(2).toList(),
          uid: uid);

      List<String> billNewImage = [];
      for (UploadingStatusManagerCubit manager in billUploadingManager) {
        String url = await _storageFacade.uploadFile(
            path: FirebaseKey.billImages,
            file: manager.state.uploadingFile!.file,
            uploadingProgress: (progress, total) {
              manager.updateProgress(progress: progress, total: total);
            });
        billNewImage.add(url);
        manager.updateUrl(url: url);
      }
      fundsRequest = fundsRequest.copyWith(
          billImages: [
        ...billNewImage,
        ...fundsRequest.billImages,
      ].take(2).toList());

      await _fundsRaisingFacade.updateFundsRequest(fundsRequest: fundsRequest);
      emit(FundsRequestState.success(fundsRequest: fundsRequest));
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRequestState.failure(message: e.toFirebaseMessage()));
    } catch (e, stackTrace) {
      debugPrint('FundsRaisingCubit.createPost: $e $stackTrace');
      emit(FundsRequestState.failure(message: e.toString()));
    }
  }
}
