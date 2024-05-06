
import 'package:studio_partner_app/src/utils/config.dart';

class BasePaths{
  static const baseImagePath = "assets/images";
  static const baseIconsPath = "assets/icons";
  static const baseAnimationPath = "assets/animations";
  static const basePlaceholderPath = "assets/placeholders";
  static const baseProdUrl = "http://productionURL.com";
  static const baseTestUrl = "https://dummyjson.com";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}