import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

class NotificationHandler {
  // Initialize

  OneSignal oneSignal = OneSignal();

  Future<void> initializeNotificaion() async {
    OneSignal.initialize('2adc2e2e-6f0d-42d1-8a9c-b792ceb91aa7');
  }

  // Request Permission

  Future<void> requestNotificationPermission() async {
    await OneSignal.Notifications.requestPermission(true);
  }

  // Check Permission

  Future<void> checkPermission(BuildContext context) async {
    await requestNotificationPermission().then(
      (value) {
        if (!(OneSignal.Notifications.permission == false)) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Notification permission denied"),
              content: const Text(
                  "We need notificaion permission to send you notification"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No Thanks"),
                ),
                TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings(
                      type: AppSettingsType.notification,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Login user with UID

  Future<void> loginUserWithUid(String uid) async {
    OneSignal.login(uid);
  }

  // Send Notification

  Future<void> sendNotification(String name) async {
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Basic ZjgzM2Y0ZGItMTExNi00NDMyLWFhMzctMTdlNDUxYWQ5MmI5'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.onesignal.com/notifications'));
    request.body =
        '''{\n         "app_id": "2adc2e2e-6f0d-42d1-8a9c-b792ceb91aa7",\n         "contents": {"en": "Called You."},\n         "headings": {"en": "$name"},\n         "included_segments": ["all_users"],\n         "android_channel_id": "db475f79-657b-40ef-9d18-48c5d4c8ddf5"\n     }''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
