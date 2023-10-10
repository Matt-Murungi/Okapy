import 'package:okapydriver/core/locator.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:okapydriver/state/vehicles.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/state/earnings.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => locator<Auth>()),
  ChangeNotifierProvider(create: (context) => locator<VehiclesController>()),
  ChangeNotifierProvider(create: (context) => locator<EarningsController>()),
  ChangeNotifierProvider(
      create: (context) => locator<AvailableJobsController>()),
];
