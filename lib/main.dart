import 'package:flutter/material.dart';
import 'pages/index.dart';
import 'pages/register-step-1.dart';
import 'pages/register-step-2.dart';
import 'pages/register-step-3.dart';
import 'pages/register-step-4.dart';
import 'pages/login-step-1.dart'; 
import 'pages/login-step-2.dart';
import 'pages/dashboard.dart'; // Importação da Dashboard
import 'style.dart';

void main() {
  runApp(DwellersApp());
}

class DwellersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: EnXStyle.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/login-step-1': (context) => const LoginStep1(),
        '/login-step-2': (context) => const LoginStep2(),
        '/register-step-1': (context) => RegisterStep1(),
        '/register-step-2': (context) => RegisterStep2(),
        '/register-step-3': (context) => const RegisterStep3(),
        '/register-step-4': (context) => RegisterStep4(),
        '/dashboard': (context) => const DashboardPage(), // Rota Consolidada
      },
    );
  }
}
