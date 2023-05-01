import 'package:image_picker/image_picker.dart';

class UploadingModel {
  final XFile file;
  final num? progress;
  final num? total;
  final bool isUploading;
  final String url;

  UploadingModel({
    required this.file,
    this.isUploading = false,
    this.progress,
    this.total,
    this.url = '',
  });

  UploadingModel copyWith({
    XFile? file,
    final num? progress,
    final num? total,
    bool? isUploading,
    String? url,
  }) {
    return UploadingModel(
      file: file ?? this.file,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      isUploading: isUploading ?? this.isUploading,
      url: url ?? this.url,
    );
  }
}
