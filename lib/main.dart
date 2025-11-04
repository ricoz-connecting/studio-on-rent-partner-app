import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("0860cadd-ea9b-4297-99a4-9be6003328c2");
  OneSignal.Notifications.requestPermission(true);
  await Future.delayed(Duration(seconds: 2));
  String? playerId = OneSignal.User.pushSubscription.id;
  log("Player ID: $playerId");
  // Initialize OneSignal
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // OneSignal.initialize("0860cadd-ea9b-4297-99a4-9be6003328c2");

  // // Request notification permission
  // await OneSignal.Notifications.requestPermission(true);

  // // Observe when push subscription is available
  // OneSignal.User.pushSubscription.addObserver((state) {
  //   String? playerId = state.current.id;
  //   log("✅ Player ID: $playerId");

  //   // You can store this Player ID to backend here!
  // });

  runApp(
    const ProviderScope(
      child: (MyApp()),
    ),
  );
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize OneSignal
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//   OneSignal.initialize("0860cadd-ea9b-4297-99a4-9be6003328c2");

//   // Request notification permission
//   await OneSignal.Notifications.requestPermission(true);

//   // Add observer to get Player ID when it becomes available
//   OneSignal.User.pushSubscription.addObserver((state) {
//     String? playerId = state.current.id;
//     log("✅ Player ID from observer: $playerId");
//     // Store playerId to backend here!
//   });

//   // OPTIONAL: Add a slight delay then check manually
//   await Future.delayed(Duration(seconds: 2));
//   String? playerId = OneSignal.User.pushSubscription.id;
//   log("🔄 Player ID after delay: $playerId");

//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        canvasColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: StudioRouter.router,
    );
  }
}
