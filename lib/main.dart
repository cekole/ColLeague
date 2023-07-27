import 'package:col_league/constants/colors.dart';
import 'package:col_league/screens/home_page.dart';
import 'package:col_league/screens/profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kprimaryColor,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kprimaryColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: kprimaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kprimaryColor,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: kprimaryColor,
          ),
        ),
      ),
      home: HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
