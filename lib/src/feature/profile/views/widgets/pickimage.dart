// import 'dart:developer';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:studio_partner_app/commons/repo/get_image_url.dart';
// import 'package:studio_partner_app/commons/views/providers/image_upload_url.dart';
// import 'package:studio_partner_app/src/feature/profile/repo/upload_image.dart';

// class Pickimage {
//   WidgetRef ref;
//   Pickimage(this.ref);
//   final ImagePicker _picker = ImagePicker();

//   Future<XFile> pickImage() async {
//     Map<String, dynamic> url = await GetImageUrl.getUploadUrl();
//     ref.read(imageUploadUrl.notifier).setImageUploadUrl(url['uploadUrl']);
//     ref.read(keyProvider.notifier).setKey(url['key']);
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       var bytes = await image.readAsBytes();
//       UploadImage.uploadImage(ref, bytes);
//       log('Image picked successfully', name: 'PickImage');
//       return image;
//     }
//     return XFile('');
//   }
// }
