import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/deliveryConfirmation/components/body.dart';

class DeliveryConfirmation extends StatelessWidget {
  static String routerName = '/delivery';
  const DeliveryConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
