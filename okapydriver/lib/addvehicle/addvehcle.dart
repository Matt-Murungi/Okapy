import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/addvehicle/components/body.dart';

class AddVehicle extends StatelessWidget {
  static String routerName = '/addvehicle';
  const AddVehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}
