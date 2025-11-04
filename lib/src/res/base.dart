import 'package:studio_partner_app/utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseProdUrl = "http://119.18.62.33:5000/api/v1/";
  static const baseTestUrl = "http://10.182.203.44:5000/api/v1/";
  // static const baseProductionSocket = "https://chat-server-qrl9.onrender.com";
  static const baseProductionSocket = "http://119.18.62.33:3000";
  static const baseTestSocket = "http://10.182.203.44:5000";

  static const storageURL =
      'https://pub-ea3040b92a0d459b98480db8632b3b03.r2.dev/';
  static const baseSocketUrl =
      AppConfig.devMode ? baseTestSocket : baseProductionSocket;
  // static const baseSocketUrl = baseProductionSocket;
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
