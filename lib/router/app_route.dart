import 'package:flutter/material.dart';
import 'package:notificaciones/screen/screen.dart';

class AppRoute {
  static const homeScreen = 'homeScreen';
  static const messageScreen = 'messageScreen';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutess = {
      homeScreen: (_) => const HomeScreen(),
      messageScreen: (_) => const MessageScreen(),
    };
    return appRoutess;
  }
}
