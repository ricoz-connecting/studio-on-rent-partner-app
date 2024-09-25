import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageUploadUrl extends StateNotifier<String> {
  ImageUploadUrl() : super('');

  void setImageUploadUrl(String url) {
    state = url;
  }
}

final imageUploadUrl = StateNotifierProvider<ImageUploadUrl, String>((ref) {
  return ImageUploadUrl();
});

class KeyProvider extends StateNotifier<String> {
  KeyProvider() : super('');

  void setKey(String key) {
    state = key;
  }
}

final keyProvider = StateNotifierProvider<KeyProvider, String>((ref) {
  return KeyProvider();
});
