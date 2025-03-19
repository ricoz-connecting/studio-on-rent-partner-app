import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/commons/views/widgets/progressdialog.dart';
import 'package:studio_partner_app/src/feature/chat_screen/repo/fetch_user_id.dart';
import 'package:studio_partner_app/src/feature/file/controller/file_controller.dart';
import 'package:studio_partner_app/utils/router.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

final chatUserControllerProvider =
    StateNotifierProvider<ChatUserController, String?>((ref) {
  final repo = ref.watch(chatUserRepoProvider);
  return ChatUserController(repo: repo, ref: ref);
});

class ChatUserController extends StateNotifier<String?> {
  final ChatUserRepo _repo;
  final Ref _ref;

  ChatUserController({required ChatUserRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(null);

  /// **Update Chat User Profile**
  Future<void> updateChatUser({
    required BuildContext context,
    required String phone,
    required String email,
    required String name,
    required String avatar,
  }) async {
    try {
      final result = await _repo.updateProfile(
        phone: phone,
        email: email,
        name: name,
        avatar: avatar,
      );

      result.fold(
        (failure) {
          context.pop();
          SnackBarService.showSnackBar(
            context: context,
            message: "Profile update failed: ${failure.message}",
            backgroundColor: Colors.red,
          );
        },
        (response) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          _ref
              .read(chatUserDocIdProvider.notifier)
              .update((state) => responseData['data']['_id'] as String?);
        },
      );
    } catch (e, stacktrace) {
      log('Error: $e', name: 'ChatUserControllerError');
      log('Stacktrace: $stacktrace', name: 'ChatUserControllerStacktrace');
    }
  }
}
