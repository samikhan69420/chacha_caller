import 'dart:convert';

import 'package:chacha_caller/features/app/const/app_auth_exception.dart';
import 'package:chacha_caller/features/calling/data/datasources/remote_data_source.dart';
import 'package:chacha_caller/features/user/data/models/user_model.dart';
import 'package:chacha_caller/features/user/domain/entity/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<void> initialAppStart() async {
    final String appId = dotenv.env['APP_ID']!;
    OneSignal.initialize(appId);
    OneSignal.Notifications.requestPermission(false);
  }

  @override
  Future<void> onesignalLogin(String uid) async {
    await OneSignal.login(uid);
    await OneSignal.User.pushSubscription.optIn();
  }

  @override
  Stream<List<UserEntity>> getWorkers() {
    final firestore = FirebaseFirestore.instance;
    final userCollection = firestore.collection('users');
    return userCollection
        .where('accountType', isEqualTo: 'WORKER')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => UserModel.from(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Future<void> sendNotification(String message, List<UserEntity> users) async {
    List<String> uidList = users.map((user) => user.uid!).toList();

    Map<String, dynamic> responseBody = {
      "app_id": dotenv.get("APP_ID"),
      "contents": {"en": message},
      "target_channel": "push",
      "include_aliases": {
        "external_id": uidList,
      }
    };

    final encodedResponse = jsonEncode(responseBody);

    final response = await http.post(
      Uri.parse('https://api.onesignal.com/notifications'),
      body: encodedResponse,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Basic ${dotenv.get("API_KEY")}',
      },
    );

    if (response.statusCode != 200) {
      throw AppAuthException(response.reasonPhrase ?? 'Unknown error');
    } else {
      debugPrint("Notification sent successfully");
    }
  }
}
