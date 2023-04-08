import 'package:flutter/material.dart';
import 'package:notificaciones/router/app_route.dart';
import 'package:notificaciones/services/push_notificacions_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerkey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationService.messagesStream.listen((message) {
      navigatorkey.currentState
          ?.pushNamed(AppRoute.messageScreen, arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerkey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
      initialRoute: AppRoute.homeScreen,
      routes: AppRoute.getAppRoutes(),
      navigatorKey: navigatorkey,
      scaffoldMessengerKey: messengerkey,
    );
  }
}
