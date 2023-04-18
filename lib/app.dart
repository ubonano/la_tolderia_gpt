import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'modules/daily_income/daily_income_list_screen.dart';
import 'modules/auth/login_screen.dart';
import 'modules/auth/auth_service.dart';
import 'utils/get_it_setup.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthService>();

    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: authService.authStateChanges,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return const DailyIncomeListScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
