import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:okapy_dashboard/auth/ui/screens/login.dart';
import 'package:okapy_dashboard/core/routes/route_strings.dart';
import 'package:okapy_dashboard/core/ui/screens/dashboard.dart';
import 'package:okapy_dashboard/history/ui/history.dart';
import 'package:okapy_dashboard/order/ui/bookings/bookings.dart';
import 'package:okapy_dashboard/order/ui/orders/orders.dart';
import 'package:okapy_dashboard/payments/ui/components/payment_view.dart';
import 'package:okapy_dashboard/payments/ui/payment.dart';
import 'package:okapy_dashboard/product/ui/product.dart';
import 'package:okapy_dashboard/profile/ui/profile.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

List<RouteBase> appRoutes = [
  ShellRoute(
      navigatorKey: _rootNavigatorKey,
      builder: (context, state, child) => Dashboard(child: child),
      routes: [
        GoRoute(
          path: productRoute,
          builder: (context, state) => const Product(),
        ),
        GoRoute(
          path: paymentRoute,
          builder: (context, state) => const Payment(),
        ),
        GoRoute(
          path: orderRoute,
          builder: (context, state) => const Orders(),
        ),
        GoRoute(
          path: bookingRoute,
          builder: (context, state) => const Bookings(),
        ),
        GoRoute(
          path: history,
          builder: (context, state) => const OrderHistory(),
        ),
        GoRoute(
          path: profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ]),
  GoRoute(
    path: loginRoute,
    builder: (context, state) => const Login(),
  ),
];
