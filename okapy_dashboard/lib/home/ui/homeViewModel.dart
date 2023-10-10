import 'package:flutter/cupertino.dart';
import 'package:okapy_dashboard/auth/domain/auth_controller.dart';
import 'package:provider/provider.dart';

class HomeViewModel {
   getUser(BuildContext context) {
    final user =   context.read<AuthController>().user!.firstName;
    return user;
  }
}
