import 'package:studio_partner_app/utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseProdUrl =
      "https://bookmystudio-dahxa2bvhad8crek.centralindia-01.azurewebsites.net/api/v1/";
  static const baseTestUrl = "http://192.168.1.12:5000/api/v1/";
  static const baseProductionSocket = "https://chat-server-qrl9.onrender.com";
  static const baseTestSocket = "https://chat-server-qrl9.onrender.com";

  static const storageURL =
      'https://pub-fa34e1d40214487bba2b2645b6ff63b1.r2.dev/';
  static const baseSocketUrl =
      AppConfig.devMode ? baseTestSocket : baseProductionSocket;
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
