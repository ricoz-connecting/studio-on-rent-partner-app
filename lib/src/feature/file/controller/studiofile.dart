import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<List<File>?> selectMultipleFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
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
}
