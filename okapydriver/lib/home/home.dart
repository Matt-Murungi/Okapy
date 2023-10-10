import 'package:flutter/material.dart';
import 'package:okapydriver/home/components/body.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static String routerName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}
