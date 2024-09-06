import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/views/providers/image_upload_url.dart';
import 'package:http/http.dart' as http;

class UploadImage {
  static Future<void> uploadImage(WidgetRef ref, Uint8List bytes) async {
    String uploadUrl = ref.watch(imageUploadUrl);
    if (uploadUrl.isNotEmpty) {
      final response = await http.put(
        Uri.parse(uploadUrl),
        headers: {'Content-Type': 'application/png'},
        body: bytes,
      );
      log(response.body, name: 'UploadImage');
    } else {
      log('Image upload url is empty', name: 'UploadImage');
    }
  }
}
