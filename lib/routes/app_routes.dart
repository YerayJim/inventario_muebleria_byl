import 'package:flutter/material.dart';
import '../modules/auth/views/login_page.dart';
import '../modules/dashboard/views/dashboard_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (BuildContext context) => LoginScreen(), // Verifica que la clase exista
  '/dashboard': (BuildContext context) => DashboardScreen(),
};
