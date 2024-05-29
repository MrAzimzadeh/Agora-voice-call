import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await handleNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
    });
  }

  Future<void> handleNotification(RemoteMessage message) async {
    String? title = message.notification?.title ?? 'Default Title';
    String? body = message.notification?.body ?? 'Default Body';
    String channelKey = message.data['channel_key'] ?? 'default_channel';

    if (channelKey == 'call_channel') {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: channelKey,
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept Call',
            color: Colors.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT',
            label: 'Reject Call',
            color: Colors.redAccent,
            autoDismissible: true,
          ),
        ],
      );
    } else if (channelKey == 'message_channel') {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 124,
          channelKey: channelKey,
          color: Colors.blue,
          title: title,
          body: body,
          category: NotificationCategory.Message,
          backgroundColor: Colors.blue,
          autoDismissible: true,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'READ',
            label: 'Read Message',
            color: Colors.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'DISMISS',
            label: 'Dismiss',
            color: Colors.red,
            autoDismissible: true,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                String? token = await FirebaseMessaging.instance.getToken();
                print('FCM Token -> $token');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Get Token")),
              ),
            ),
            InkWell(
              onTap: () {
                sendNotification('message_channel');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Send Message Notification")),
              ),
            ),
            InkWell(
              onTap: () {
                sendNotification('call_channel');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Send Call Notification")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  Future<void> sendNotification(String channelKey) async {
    try {
      final accountCredentials = auth.ServiceAccountCredentials.fromJson({
        'type': 'service_account',
        'project_id': 'voice-call-d4ef5',
        'private_key_id': '7acf83d6f2c8572a4cc7ccc2cf1e23498e9bec9f',
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCS1GQkF0//qEEf\nyzJe1LWfDfsYygGYqZQ7CqYtR6aTf30AME7+ARe3X58Fjk9htu1hDLE+l2NejpSL\nkXr2X8qsa+SHSH1F6G9IdKPTWT4I2I6boyCDtBbmcRGAXZaTEFttvr7m45qQ1YpA\nLH7urA2ekcNbs6S2bfEqSYwYbdIQn9nez1ilFKDF2hwFOAAUni9q4etYdBMKIQda\nEjupRPR9Hqo3Yz/oaR612s5QantQ6e1G9BkNh9Bgl7FGXcKr5FmASQV3FCKm8mgy\nKUwE0Nk7t+MW1G4+S3xk1RL68MIvPySaFLvDiKF8vTxA3Ex7chhUH+/1XgeX+OuL\njbiD8KzbAgMBAAECggEAGpHzszJCyEVWz52SNmXwneFGTJSVmF4rlEmXi78ZDjz2\nTlfvm3hwJb9YhAVeKRUUvMiytFxp330WtXD0muv3vZ7ionaEMOfgZ3CwCrluB+TE\nXba11g97S2UvoRaOfntpyCDJ4/dRC5+Q3o8OwzsAVe8Ttp76EgcwKpJXlz4cUuSM\nNm/3yt6MJYY+9JEfungvonIoK6+gVYcxSBc9nGItymaY6/m35cXUUsTpO9Mu852K\nb0DbYJLXC378hWAy4VqHgtayiANnhEmY+V4F3WNXObXpgnVkxRDRE36Qrhy2AXdN\nI7rndHsGWTWNUirJ1PlsLj3YWKCQSkSbrMs2NOw/HQKBgQDFtEyslMl6YCSFYj9s\n1J5HUccvYGD/fhdiG2fgWIWUl90YNihXhg6OispnX/yAJvOgy7MtJWN3KVF8c5En\njECX6j+r1SelofAURrobW3uk7F7n0aE9bApLiP1ig6k/+4o/0Tj4ivuxZvQRKm5K\ngsNHsJl7Buqg14H6NU8RHq8xZwKBgQC+H9JJkeZXuxAe72JMIfbnKsFrW/frr1za\nZPVq+/ZGZpHlW5ujPoQXugNEVOSZ9JR1dM3KFTsIbDwoXEazuEQUMCKN/ur/jqOw\nV1fZvHxsfJFDL+WHpvN9HZn4kgQagmykkLvVMZxt9Y9ZcGBjDJGmHFTDhCFrVOoK\ndxcj/Me8bQKBgHakoZK740D2K1SERi2oVqfUEqWCwBLy91NfwPGoDdnDXOIntgP4\nJgoyjg6FUsERHwky1P7VviAHgqgdrlE+YJEJ+VXEH/vM94cjfpHmT4gEdVvGuG1k\nxbTYq76P5mTILgnoI7k7ppmqf/NBNFiwqkH+X8yttOX7Djw5+435jQcnAoGARm5X\nYnWwFRPxNuSLT5TNeHl4SaM6Ro8iIK2B1O4eH5pjtcmn8GN6X6fDCg9A2F+ol5J7\nob8XrVkbOABnGLDMV4Y1ZtDmkWFv9iWFH94ZYb8LuQ4HQ6dvUAwlO9Yruv5R7OzJ\nCINmZb2wKvvcWRUQ565bIErUboR4ZwQTCHveKkkCgYBgnugylitlCGMAdCgjGEgi\n3kRI1xllP24eT6mWVmcxrr9WFx7pOWfvu/11pimbVUpy/kKYh4gdvU5ywG9oF5QD\nKnGxTejY+cgSWtu1nDywdY2mXZqRVVs6PLk/PctYwUhjyynP7N7r549dIbSlx9ZI\nBHrwuSMQSfLRtUIGpz+NBQ==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-an78q@voice-call-d4ef5.iam.gserviceaccount.com",
        "client_id": "116219170346349172255",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-an78q%40voice-call-d4ef5.iam.gserviceaccount.com",
      });

      final authClient =
          await auth.clientViaServiceAccount(accountCredentials, _scopes);
      final accessToken = await authClient.credentials.accessToken;

      final response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/voice-call-d4ef5/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${accessToken.data}',
        },
        body: jsonEncode({
          "message": {
            "token":
                'dSnSTXUfQ3KcK4WaGENWch:APA91bFtLgHWjgNAvnaovgTFnV-3xknBgpW8Ba80Y8j6UI3QtSElmI1aJayzJ7TM861z-tcexSMVcXW0y4gMdE-Kqf8NKqfJ7vBU6YHKDe0QeHqX3jNFJxpSbnR6Pj8KhGRKQBJTM-gi',
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "id": "1",
              "status": "done",
              "channel_key": channelKey,
              'title': 'Title',
              'body': 'Body',
            }
          }
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
