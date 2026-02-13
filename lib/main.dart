import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/common/app_constants.dart';
import 'package:testapp/core/network/api_endpoints.dart';
import 'package:testapp/features/dashboard/view/dashboard_screen.dart';
import 'package:testapp/features/portfolio/provider/portfolio_provider.dart';
import 'package:testapp/features/portfolio/service/portfolio_service.dart';
import 'package:testapp/theme/controller/theme_controller.dart';

import 'core/network/dio/dio_client.dart';
import 'core/network/dio/logging_interceptor.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final dioClient = DioClient(
    ApiEndpoints.baseUrl,
    loggingInterceptor: LoggingInterceptor(),
    sharedPreferences: sharedPreferences,
  );

  final portfolioService = PortfolioService(dioClient: dioClient);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              ThemeController(sharedPreferences: sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              PortfolioProvider(service: portfolioService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.isDarkTheme
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const DashboardScreen(),
        );
      },
    );
  }
}
