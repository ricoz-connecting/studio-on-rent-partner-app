import 'package:studio_partner_app/utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseProdUrl = "https://fastx-server.azurewebsites.net/api/v1";
  static const baseTestUrl = "http://192.168.1.5:3000/api/v1";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
