import 'package:studio_partner_app/utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseProdUrl =
      "https://bookmystudio-new-backend.onrender.com/api/v1/";
  static const baseTestUrl =
      "https://bookmystudio-new-backend.onrender.com/api/v1/";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
