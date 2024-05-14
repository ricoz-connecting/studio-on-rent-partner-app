import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/features/stores/data/model/category_model.dart';
import 'package:studio_partner_app/src/features/stores/data/model/location_model.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class StoreRemoteDataSource {
  FutureEitherFailure<LocationModel> getUserLocation();
  FutureEitherFailure<List<CategoryEntity>> getCategorydata();
}

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  @override
  FutureEitherFailure<LocationModel> getUserLocation() async {
    try {
      PermissionStatus status = await Permission.location.request();
      if (status.isDenied) {
        throw ApiException(message: "We Need Your Location Access");
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark placemark = placemarks.first;

        LocationModel locationModel = LocationModel(
            location: placemark.locality ??
                placemark.administrativeArea ??
                placemark.name ??
                placemark.street ??
                placemark.subLocality ??
                'No Name Please Change it.',
            latitude: position.latitude,
            longitude: position.longitude);
        return Right(locationModel);
      }
    } on ApiException catch (e) {
      log('Error getting location: $e');
      return left(ApiFailure(messages: e.message));
    } catch (e) {
      log('Error getting location: $e');
      return left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<CategoryEntity>> getCategorydata() async {
    try {
      final response = await http
          .get(Uri.parse("${AppUrls.baseUrl}${AppUrls.categoryEndpoint}"));
      if (response.statusCode == 200) {
        final body = List<Map<String, dynamic>>.from(jsonDecode(response.body));

        final categoryModels =
            body.map<CategoryModel>((e) => CategoryModel.fromMap(e)).toList();

        return Right(categoryModels);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e);
      return left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);
      return left(ApiFailure(messages: e.toString()));
    }
  }

  // @override
  // FutureEitherFailure<Null> submitStudioRequest() {
  //   try {

  //   } catch (e) {
  //     return Left(ApiFailure(messages: e.toString()));
  //   }
  // }
}
