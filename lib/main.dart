import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/http_service.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/data/local/local_notification_service.dart';
import 'package:restaurant_app/provider/provider_package.dart';
import 'package:restaurant_app/routes/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:restaurant_app/package.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
        Provider(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        Provider(
          create: (context) => HttpService(),
        ),
        Provider(
          create: (context) => LocalNotificationService(
            context.read<HttpService>(),
          )..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>()
          )..requestPermissions(),
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
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: value.isDarkModeOn ? RestaurantTheme.darkTheme : RestaurantTheme.lightTheme,
          darkTheme: value.isLightModeOn ? RestaurantTheme.lightTheme : RestaurantTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
            NavigationRoute.settingsRoute.name: (context) =>
                const SettingsScreen(),
          },
        );
      },
    );
  }
}
