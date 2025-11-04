import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:studio_partner_app/src/res/key.dart';

// class NotificationService {
//   String url = "https://api.onesignal.com/notifications";
//   Future<void> sendNotification(String title, String desc) async {
//     try {
//       var response = await http.post(
//         Uri.parse(url),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Basic ${OneSignalKey.apiKey}"
//         },
//         body: jsonEncode({
//           "app_id": OneSignalKey.appId,
//           "included_segments": ["Total Subscriptions"],
//           "data": {"foo": "bar"},
//           "headings": {"en": "$title"},
//           "contents": {"en": "$desc"},
//         }),
//       );
//       if (response.statusCode == 200) {
//         log("Notification sent successfully");
//       } else {
//         log("Failed to send notification");
//       }
//     } on Exception catch (e) {
//       log("Error occured Send Notification : $e");
//     }
//   }
// }

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  static const String _url = "https://api.onesignal.com/notifications";

  Future<void> sendNotification({
    required String playerId,
    required String title,
    required String desc,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic ${OneSignalKey.apiKey}",
        },
        body: jsonEncode({
          "app_id": OneSignalKey.appId,
          "included_segments": ["Total Subscriptions"],
          "data": {"foo": "bar"},
          "headings": {"en": title},
          "contents": {"en": desc},
        }),
      );

      log("Send Notification Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("✅ Notification sent successfully");
      } else {
        log("❌ Failed to send notification: ${response.body}");
      }
    } catch (e, stackTrace) {
      log("🚨 Error occurred while sending notification: $e",
          stackTrace: stackTrace);
    }
  }
}
