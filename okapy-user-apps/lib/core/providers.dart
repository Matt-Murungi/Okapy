import 'package:okapy/core/locator.dart';
import 'package:okapy/state/auth.dart';
import 'package:okapy/state/bookings.dart';
import 'package:okapy/state/order.dart';
import 'package:okapy/state/payment.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => locator<Auth>()),
  ChangeNotifierProvider(create: (context) => locator<Bookings>()),
  ChangeNotifierProvider(create: (context) => locator<Payment>()),
  ChangeNotifierProvider(create: (context) => locator<Order>()),
];
