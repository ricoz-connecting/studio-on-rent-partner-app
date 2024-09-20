import 'package:flutter_riverpod/flutter_riverpod.dart';

class Authprovider extends StateNotifier<String> {
  Authprovider() : super('');

  void auth(String auth) {
    state = auth;
  }
}

final authprovider = StateNotifierProvider<Authprovider, String>((ref) {
  return Authprovider();
});
