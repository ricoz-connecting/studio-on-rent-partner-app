import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:studio_partner_app/src/commons/params/register_params.dart';
// locationFromAdd(String location) async {
//   try {
//     final localLocation =
//         await GeocodingPlatform.instance!.locationFromAddress(location);
//     latitude = localLocation.first.latitude;
//     longitude = localLocation.first.longitude;
//     print(latitude);
//     print(longitude);
//   } catch (e) {
//     latitude = 0;
//     longitude = 0;
//   }
// }

// locationFromAddforStudio(String location) async {
//   final localLocation =
//       await GeocodingPlatform.instance!.placemarkFromCoordinates(location);
//   final latitude = localLocation.first.latitude;
//   final longitude = localLocation.first.longitude;
//   print(latitude);
//   print(longitude);
//   return [latitude, longitude];
// }

DocumentType stringToEnum(String value) {
  log(value);
  return DocumentType.values.firstWhere(
    (e) => e.toString().split('.')[1] == value,
  );
}
