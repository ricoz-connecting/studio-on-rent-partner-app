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

final authTokenProvider = StateProvider<String?>((ref) =>
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmQ1YzQwYTI1MjIxYzA1ZmM5MGU0NzYiLCJpYXQiOjE3MjY5MjIzNTksImV4cCI6MTcyOTUxNDM1OX0.gZD9fgUUb8KPI4U4oNuQxaRI_yg_jV6Zt2ClULqYcnw");
