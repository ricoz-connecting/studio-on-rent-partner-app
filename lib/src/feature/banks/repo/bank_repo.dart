import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:studio_partner_app/src/core/core.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class BankRepo {
  final API _api;
  final Ref _ref;

  BankRepo({required API api, required Ref ref})
      : _api = api,
        _ref = ref;

  // Add a bank detail
  FutureEither<Response> addBankDetail({
    required String bankName,
    required String accountHolderName,
    required String accountNumber,
    required String ifscCode,
    required bool primary,
  }) async {
    final body = {
      "bankName": bankName,
      "accountHolderName": accountHolderName,
      "accountNumber": accountNumber,
      "IFSCcode": ifscCode,
      "primary": primary,
    };

    final result = await _api.postRequest(
      url: Endpoints.addBank,
      body: body,
    );
    return result;
  }

  // Fetch list of bank details
  FutureEither<Response> getBankDetails() async {
    final result = await _api.getRequest(
      url: Endpoints.getBank,
      requireAuth: true,
    );
    return result;
  }

  // Delete a bank detail by ID
  FutureEither<Response> deleteBankDetail(String bankId) async {
    final result = await _api.deleteRequest(
      url: "${Endpoints.deleteBank}/$bankId",
      body: {},
      requireAuth: true,
    );
    return result;
  }

  // Update a bank detail by ID
  // FutureEither<Response> updateBankDetail({
  //   required String bankId,
  //   required String bankName,
  //   required String accountHolderName,
  //   required String accountNumber,
  //   required String ifscCode,
  //   required bool primary,
  // }) async {
  //   final body = {
  //     "bankName": bankName,
  //     "accountHolderName": accountHolderName,
  //     "accountNumber": accountNumber,
  //     "IFSCcode": ifscCode,
  //     "primary": primary,
  //   };

  //   final result = await _api.patchRequest(
  //     url: "${Endpoints.updateBank}/$bankId",
  //     body: body,
  //     requireAuth: true,
  //   );
  //   return result;
  // }

  FutureEither<Response> updateBankDetail({
    required String bankId,
    required Map<String, dynamic> payload,
  }) async {
    // Create body dynamically to include only non-null values

    if (payload.isEmpty) {
      return Left(Failure(message: "No fields provided to update."));
    }

    final result = await _api.patchRequest(
      url: "${Endpoints.updateBank}/$bankId",
      body: payload,
      requireAuth: true,
    );

    return result;
  }

  FutureEither<Response> fetchBankDetailsByIFSC(String ifscCode) async {
    final result = await _api.getRequest(
      url: "${Endpoints.getDetailsByIFSC}/$ifscCode",
      requireAuth: true,
    );
    return result;
  }
}

// Provider for BankRepo
final bankRepoProvider = Provider<BankRepo>((ref) {
  final api = ref.watch(apiProvider);
  return BankRepo(api: api, ref: ref);
});
