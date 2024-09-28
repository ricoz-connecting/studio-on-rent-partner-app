// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:studio_partner_app/src/core/api.dart';
// import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
// import 'package:studio_partner_app/src/res/endpoints.dart';
// import 'package:studio_partner_app/utils/router.dart';

// import '../models/profile.dart';

// class Editprofile {
//   Profile? profile;
//   Editprofile({
//     required this.profile,
//   });

//   Future<void> editProfile(WidgetRef ref, BuildContext context) async {
//     final authToken = ref.watch(authTokenProvider);
//     API api = API(authToken: authToken);
//     Profile profileLocal = Profile(
//         name: profile!.name,
//         avatar: profile!.avatar,
//         gender: profile!.gender,
//         address: profile!.address,
//         city: profile!.city,
//         pincode: profile!.pincode,
//         state: profile!.state,
//         country: profile!.country,
//         latitude: profile!.latitude,
//         longitude: profile!.longitude,
//         businessName: profile!.businessName);
//     final Map<String, dynamic> body = {
//       if (profileLocal.name != null) 'name': profileLocal.name,
//       if (profileLocal.avatar != null) 'avatar': profileLocal.avatar,
//       if (profileLocal.gender != null) 'gender': profileLocal.gender,
//       if (profileLocal.address != null) 'address': profileLocal.address,
//       if (profileLocal.city != null) 'city': profileLocal.city,
//       if (profileLocal.pincode != null) 'pincode': profileLocal.pincode,
//       if (profileLocal.state != null) 'state': profileLocal.state,
//       if (profileLocal.country != null) 'country': profileLocal.country,
//       if (profileLocal.latitude != null) 'latitude': profileLocal.latitude,
//       if (profileLocal.longitude != null) 'longitude': profileLocal.longitude,
//       if (profileLocal.businessName != null)
//         'businessName': profileLocal.businessName,
//     };
//     final response =
//         await api.patchRequest(url: Endpoints.editProfile, body: body);

//     response.fold((error) {
//       log(error.message);
//     }, (response) {
//       log(response.body);
//       final Map<String, dynamic> responseBody = jsonDecode(response.body);
//       if (responseBody['success'] == true) {
//         GoRouter.of(context).go(StudioRoutes.bottomNavBar);
//       }
//     });
//   }
// }
