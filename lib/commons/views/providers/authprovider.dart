import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/models/user_model.dart';

final authTokenProvider = StateProvider<String?>((ref) => null);
final currentUserProvider = StateProvider<User?>((ref) => null);
