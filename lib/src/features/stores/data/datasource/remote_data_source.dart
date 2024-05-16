import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/params/studio_params.dart';
import 'package:studio_partner_app/src/features/stores/data/model/category_model.dart';
import 'package:studio_partner_app/src/features/stores/data/model/location_model.dart';
import 'package:studio_partner_app/src/features/stores/data/model/studio_model.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/res/data.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

abstract class StoreRemoteDataSource {
  FutureEitherFailure<LocationModel> getUserLocation();
  FutureEitherFailure<List<CategoryEntity>> getCategorydata();
  FutureEitherFailure<StudioEntity> submitStudioRequest(StudioParams params);
  FutureEitherFailure<StudioDetails> getStudioDetails(String studioId);
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

  @override
  FutureEitherFailure<StudioEntity> submitStudioRequest(
      StudioParams params) async {
    try {
      final request = http.MultipartRequest("POST",
          Uri.parse('${AppUrls.baseUrl}${AppUrls.studioRequestEndPoint}'));

      request.fields['fields'] = jsonEncode(params.toMap());
      request.files.add(http.MultipartFile.fromBytes('Cover', params.cover));
      request.files.addAll(params.frontImage
          .map((e) => http.MultipartFile.fromBytes("FrontImage", e,
              filename: 'FrontImage'))
          .toList());
      request.files.addAll(params.gallary
          .map((e) =>
              http.MultipartFile.fromBytes("Gallary", e, filename: 'Gallary'))
          .toList());

      final response = await request.send();
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        log(data.runtimeType.toString());
        final body = data.runtimeType == String ? jsonDecode(data) : data;
        return Right(StudioModel.fromMap(body));
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<StudioDetails> getStudioDetails(String studioId) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.descriptionEndpoint}/$studioId"));
      if (response.statusCode == 200) {
        // log(response.body);
        final body = response.body.runtimeType == String
            ? jsonDecode(response.body)
            : response.body;
        final studio = StudioDetails.fromMap(body['studio']);
        final reviews = (body['review'] as List)
            .map<ReviewModel>(
              (e) => ReviewModel.fromMap(e),
            )
            .toList();
        AppData.reviewModels = reviews;
        return Right(studio);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      log(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      log(e.toString());
      return Left(ApiFailure(messages: e.toString()));
    }
  }
}
