import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:okapydriver/models/userModel.dart';

import '../models/authmodel.dart';
import 'components/body.dart';


class BankingDetails extends StatelessWidget {
  static String routerName = '/profile';
  const BankingDetails({Key? key, required this.authModel}) : super(key: key);
  final UserModel authModel;
  @override
  Widget build(BuildContext context) {

    return  Body(
      authModel: authModel,
    );
  }
}
