import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/notification/components/body.dart';

class NotificationScreen extends StatelessWidget {
  static String routerName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
