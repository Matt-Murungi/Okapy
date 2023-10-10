import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/models/BookingDetailsModel.dart';
import 'package:okapydriver/models/userModel.dart';
import 'package:okapydriver/profile/components/body.dart';

class Profile extends StatelessWidget {
  static String routerName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    UserModel _user = arg['user'] as UserModel;

    return Body(
      user: _user,
    );
  }
}
