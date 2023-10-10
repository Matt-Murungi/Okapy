import 'package:get_it/get_it.dart';
import 'package:okapydriver/core/api.dart';
import 'package:okapydriver/models/availableJobs.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/chat.dart';
import 'package:okapydriver/state/earnings.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/state/vehicles.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerFactory(() => Auth());
  locator.registerFactory(() => VehiclesController());
  locator.registerFactory(() => AvailableJobsController());
  locator.registerFactory(() => EarningsController());
  // locator.registerFactory(() => Chat());
  locator.registerFactory(() => Api());
}
