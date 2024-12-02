import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'utils/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: (MyApp()),
    ),
  );
}

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
