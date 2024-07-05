import 'package:ecommerce_flutter_application/bloc/authentication/auth_bloc.dart';
import 'package:ecommerce_flutter_application/data/model/basket_item.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/screens/dashboard_screen.dart';
import 'package:ecommerce_flutter_application/screens/login_screen.dart';
import 'package:ecommerce_flutter_application/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

GlobalKey<NavigatorState> globalNavigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Beacuse in "await getItInit();" in di.dart file needs Hive so we should open hive "next 3 lines" before "await getItInit();"
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('BasketBox');
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: globalNavigationKey,
      home: (AuthManager.readAuth().isEmpty)
          ? LoginScreen()
          : const DashboardScreen(),
    );
  }
}
