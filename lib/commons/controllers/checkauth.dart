import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/providers/authprovider.dart';

class Checkauth {
  static Future<String> checkAuth(WidgetRef ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    ref.read(authTokenProvider.notifier).state = token ?? '';
    // ref.read(authprovider.notifier).auth(token ?? '');
    return token ?? '';
  }
}
