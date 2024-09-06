import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studio_partner_app/src/feature/profile/repo/upload_image.dart';

class Pickimage {
  WidgetRef ref;
  Pickimage(this.ref);
  final ImagePicker _picker = ImagePicker();

  Future<XFile> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var bytes = await image.readAsBytes();
      UploadImage.uploadImage(ref, bytes);
      log('Image picked successfully', name: 'PickImage');
      return image;
    }
    return XFile('');
  }
}
