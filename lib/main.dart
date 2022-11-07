import 'package:cattle_guru/features/splash/splash_screen.dart';
import 'package:cattle_guru/firebase_options.dart';
import 'package:cattle_guru/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Cattle Guru',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const SplashScreen(),
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }
    );
  }
}


