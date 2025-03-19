import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/src/feature/file/repository/studio_file_repo.dart';

final studioFileControllerProvider = Provider((ref) => StudiofileController());

class StudiofileController {
  Future<File?> selectFile() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      File imageFile = File(image!.path);
      return imageFile;
    } catch (e) {
      log("Failed to pick image");
      return null;
    }
  }

  Future<List<File>?> selectMultipleFiles({bool allowVideo = false}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: allowVideo ? FileType.video : FileType.image,
        allowMultiple: allowVideo ? false : true,
      );
      if (result != null) {
        final List<File> files =
            result.paths.map((path) => File(path!)).toList();
        return files;
      }
    } catch (e) {
      log("Failed to pick images: $e");
    }
    return null;
  }

  Future<String?> uploadStudioVideos(
      {required File videos, required WidgetRef ref}) async {
    try {
      final videoinfo = await ref
          .read(studioFileRepoProvider)
          .uploadFile(file: videos, type: UploadFileType.VIDEOS);
      if (videoinfo != null) {
        return videoinfo.downloadUrl;
      }
    } catch (e) {
      log("Failed to upload video: $e");
    }
    return null;
  }
}
