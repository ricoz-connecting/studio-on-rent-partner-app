import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/commons/controllers/shared_prefs_controller.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/core/core.dart';

import 'status_controller.dart';

final initControllerProvider = Provider((ref) {
  return InitController(ref: ref);
});

class InitController {
  final Ref _ref;

  InitController({required Ref ref}) : _ref = ref;

  FutureVoid initUserAndToken(BuildContext context) async {
    await _ref.read(sharedPrefsControllerPovider).getUser().then((value) {
      _ref.read(currentUserProvider.notifier).update((state) => value);
    });

    await _ref.read(sharedPrefsControllerPovider).getCookie().then((value) {
      
      log(value.toString());
      _ref.read(authTokenProvider.notifier).update((state) => value);
    });
  }
}
