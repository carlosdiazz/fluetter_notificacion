import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStreamControler =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStreamControler.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('_backgroundHandler => ${message.messageId}');
    _messageStreamControler.add(message.notification?.body ?? 'No title');
  }

  static Future _onMessageHanlder(RemoteMessage message) async {
    //print('_onMessageHanlder => ${message.messageId}');
    _messageStreamControler.add(message.notification?.body ?? 'No title');
  }

  static Future _onOpenMessage(RemoteMessage message) async {
    //print('_onOpenMessage => ${message.messageId}');
    _messageStreamControler.add(message.notification?.body ?? 'No title');
  }

  static Future initializeApp() async {
    // Push Notificacion
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    //Handles
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHanlder);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessage);

    //Local Notificacion
  }
}
