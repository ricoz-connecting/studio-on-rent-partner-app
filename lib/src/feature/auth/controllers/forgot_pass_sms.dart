// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:studio_partner_app/src/feature/auth/repo/forgot_pass_sms.dart';
// import 'package:studio_partner_app/utils/router.dart';

// class ForgotPassSms {
//   final String phoneNumber;
//   final BuildContext context;

//   ForgotPassSms({
//     required this.context,
//     required this.phoneNumber,
//   });

//   Future<void> forgotPassSMS(WidgetRef ref) async {
//     try {
//       final result = await ForgotPassSmsRepo.forgotPassSms(phoneNumber);
//       if (result == false) {
//         context.mounted
//             ? ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('An unexpected error occurred'),
//                 ),
//               )
//             : null;
//       } else {
//         // String token = await Checkauth.checkAuth(ref);
//         // Map<String, dynamic> url = await GetImageUrl.getUploadUrl();
//         // ref.read(imageUploadUrl.notifier).setImageUploadUrl(url['uploadUrl']);
//         // ref.read(keyProvider.notifier).setKey(url['key']);
//         // if (token != '') {
//         // context.mounted ? await GetProfile.getProfile(context, ref) : null;
//         context.mounted
//             ? GoRouter.of(context)
//                 .push(StudioRoutes.verifyOtpScreen, extra: phoneNumber)
//             : null;
//         // }
//       }
//     } catch (e) {
//       log(e.toString());
//       context.mounted
//           ? ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('An unexpected error occurred'),
//               ),
//             )
//           : null;
//     }
//   }
// }
