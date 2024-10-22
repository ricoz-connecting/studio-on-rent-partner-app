import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/feature/file/repository/file_repo.dart';
import 'package:studio_partner_app/src/res/base.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class ComplaintRepo {
  final API _api;
  final Ref _ref;

  ComplaintRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  FutureEither<Response> addComplaint({
    required String title,
    required String description,
    File? file,
  }) async {
    final currentUser = _ref.watch(currentUserProvider);
    final body = {
      "subject": title,
      "description": description,
      "email": currentUser!.email,
    };
    if (file != null) {
      final frontinfo = await _ref
          .read(fileRepoProvider)
          .uploadFile(file: file, type: UploadFileType.COMPLAINT);
      if (frontinfo != null) {
        body['image'] = "${BasePaths.storageURL}${frontinfo.key}";
      }
    }
    final result = await _api.postRequest(
      url: Endpoints.createComplaint,
      body: body,
    );
    return result;
  }

  FutureEither<Response> getComplaints() async {
    final result = await _api.getRequest(
      url: Endpoints.getComplaints,
      requireAuth: true,
    );
    return result;
  }
}

final complaintRepoProvider = Provider<ComplaintRepo>((ref) {
  final api = ref.watch(apiProvider);
  return ComplaintRepo(api: api, ref: ref);
});
