import 'package:studio_partner_app/src/res/strings.dart';

class ApiException implements Exception {
  final String message;

  ApiException({this.message=AppFailures.apiFailure});
}
