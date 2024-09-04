import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/navigation/navigation_page.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';
import 'package:studio_partner_app/utils/authprovider.dart';

class Editprofile {
  String? name;
  String? avatar;
  String? gender;
  String? address;
  String? city;
  String? pincode;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? businessName;

  Editprofile(
      {this.name,
      this.avatar,
      this.gender,
      this.address,
      this.city,
      this.pincode,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.businessName});

  Future<void> editProfile(WidgetRef ref, BuildContext context) async {
    final authToken = ref.read(authprovider);
    API api = API(authToken: authToken);
    final Map<String, dynamic> body = {};
    if (name != null) body['name'] = name;
    if (avatar != null) body['avatar'] = avatar;
    if (gender != null) body['gender'] = gender;
    if (address != null) body['address'] = address;
    if (city != null) body['city'] = city;
    if (pincode != null) body['pincode'] = pincode;
    if (state != null) body['state'] = state;
    if (country != null) body['country'] = country;
    if (latitude != null) body['latitude'] = latitude;
    if (longitude != null) body['longitude'] = longitude;
    if (businessName != null) body['businessName'] = businessName;
    final response =
        await api.patchRequest(url: Endpoints.editProfile, body: body);
    response.fold((error) {
      log(error.message);
    }, (response) {
      log(response.body);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBar()));
      }
    });
  }
}
