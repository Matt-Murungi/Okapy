import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:okapy_dashboard/core/controller/core_controller.dart';
import 'package:okapy_dashboard/core/data/local_data_source/local_storage.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/routes/routes.dart';
import 'package:okapy_dashboard/core/ui/screens/page_not_found.dart';
import 'package:okapy_dashboard/payments/controller/payment_controller.dart';
import 'package:okapy_dashboard/product/controller/product_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'order/controller/order_controller.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthController(),
    ),
    ChangeNotifierProvider(
      create: (_) => CoreController(),
    ),
    ChangeNotifierProvider(
      create: (_) => OrderController(),
    ),
    ChangeNotifierProvider(
      create: (_) => PaymentController(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProductController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String> _initialRouteFuture;

  @override
  void initState() {
    super.initState();
    _initialRouteFuture = _getInitialRoute();
  }

  Future<String> _getInitialRoute() async {
    final isLogIn = await LocalStorage.getLoginState();
    return isLogIn ? bookingRoute : loginRoute;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _initialRouteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final initialRoute = snapshot.data!;
          return MaterialApp.router(
            title: 'Okapy Secure',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: GoRouter(
              routes: appRoutes,
              initialLocation: initialRoute,
              errorBuilder: (context, state) => PageNotFound(
                state: state,
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}
