import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Weight Tracker Interview Showcase',
            home: child,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
          );
        },
        child: const AppWrapper(),
      ),
    );
  }
}
