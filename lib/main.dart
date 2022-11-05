import 'package:cattle_guru/features/login/ui/screens/sign_in.dart';
import 'package:cattle_guru/features/splash/splash_screen.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void main() {
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


