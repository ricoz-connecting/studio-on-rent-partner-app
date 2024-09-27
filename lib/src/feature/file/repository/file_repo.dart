import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

final fileRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return FileRepo(api: api);
});

class FileRepo {
  final API _api;
  FileRepo({required API api}) : _api = api;

  Future<UplaodInfo?> _getUploadUrl({
    required String extension,
    required UploadFileType type,
  }) async {
    final body = {"extension": extension, "type": type.text};

    final result = await _api.postRequest(
        url: Endpoints.fetchUploadImageUrl, body: body, requireAuth: false);
    return result.fold((l) {
      log('Failed to get downloadUrl');
      return null;
    }, (r) {
      final data = jsonDecode(r.body);
      final info = UplaodInfo.fromJson(data);
      return info;
    });
  }

  Future<UplaodInfo?> uploadFile(
      {required File file, required UploadFileType type}) async {
    final extension = _getFileExstension(file);
    final info = await _getUploadUrl(extension: extension, type: type);
    if (info != null) {
      final fileUploadSuccess =
          await _upload(file: file, uploadUrl: info.uploadUrl);
      if (fileUploadSuccess) {
        log('File Uploaded succfully');
        return info;
      }
    }
    return null;
  }

  Future<bool> _upload({required File file, required String uploadUrl}) async {
    log('Uploading File to $uploadUrl');
    final response =
        await http.put(Uri.parse(uploadUrl), body: file.readAsBytesSync());
    return (response.statusCode == 200);
  }

  String _getFileExstension(File file) {
    final String filePath = file.path;
    final String extension = path.extension(filePath);
    final ext = extension.substring(1);
    log("File extension : $ext");
    return ext;
  }
}

enum UploadFileType {
  AVATAR('AVATAR');

  final String text;
  const UploadFileType(this.text);

  factory UploadFileType.fromText(String text) {
    switch (text) {
      case "avatar":
        return UploadFileType.AVATAR;
    }
    return UploadFileType.AVATAR;
  }
}

UplaodInfo uplaodInfoFromJson(String str) =>
    UplaodInfo.fromJson(json.decode(str));

String uplaodInfoToJson(UplaodInfo data) => json.encode(data.toJson());

class UplaodInfo {
  final String uploadUrl;
  final bool success;
  final String fileName;
  final String downloadUrl;
  final String key;

  UplaodInfo({
    required this.uploadUrl,
    required this.success,
    required this.fileName,
    required this.downloadUrl,
    required this.key,
  });

  UplaodInfo copyWith({
    String? uploadUrl,
    bool? success,
    String? fileName,
    String? downloadUrl,
    String? key,
  }) =>
      UplaodInfo(
        uploadUrl: uploadUrl ?? this.uploadUrl,
        success: success ?? this.success,
        fileName: fileName ?? this.fileName,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        key: key ?? this.key,
      );

  factory UplaodInfo.fromJson(Map<String, dynamic> json) => UplaodInfo(
        uploadUrl: json["uploadUrl"],
        success: json["success"],
        fileName: json["fileName"],
        downloadUrl: json["downloadUrl"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "uploadUrl": uploadUrl,
        "success": success,
        "fileName": fileName,
        "downloadUrl": downloadUrl,
        "key": key,
      };
}
