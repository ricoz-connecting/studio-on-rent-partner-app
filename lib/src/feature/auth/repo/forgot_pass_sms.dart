// import 'dart:convert';
// import 'package:studio_partner_app/src/core/core.dart';
// import 'package:studio_partner_app/src/res/endpoints.dart';

// class ForgotPassSmsRepo {
//   static Future<bool> forgotPassSms(String phoneNumber) async {
//     API api = API(authToken: '');
//     final result = await api.postRequest(
//       url: Endpoints.sendOtp,
//       body: {
//         "otpType": "forChangePassword",
//         "phone": "+91$phoneNumber",
//       },
//       requireAuth: false,
//     );
//     return result.fold(
//       (failure) => false,
//       (response) async {
//         final Map<String, dynamic> responseBody = jsonDecode(response.body);
//         if (responseBody['success'] == false) {
//           return false;
//         } else {
//           return true;
//         }
//       },
//     );
//   }
// }
