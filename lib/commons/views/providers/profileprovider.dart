import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../src/feature/profile/models/profile.dart';

class Profileprovider extends StateNotifier<Profile> {
  Profileprovider() : super(Profile());

  void setProfile(Profile profile) {
    state = profile;
  }
}

final profileProvider = StateNotifierProvider<Profileprovider, Profile>((ref) {
  return Profileprovider();
});
