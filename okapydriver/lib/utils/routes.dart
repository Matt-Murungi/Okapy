import 'package:flutter/material.dart';
import 'package:okapydriver/ForgotPasswordEmail/ForgotPasswordEmail.dart';
import 'package:okapydriver/addvehicle/addvehcle.dart';
import 'package:okapydriver/chat/chat.dart';
import 'package:okapydriver/deliveryConfirmation/deliveryConfrmation.dart';
import 'package:okapydriver/docs/docs.dart';
import 'package:okapydriver/home/home.dart';
import 'package:okapydriver/notification/notification.dart';
import 'package:okapydriver/profile/profile.dart';
import 'package:okapydriver/login/login.dart';
import 'package:okapydriver/order/order.dart';
import 'package:okapydriver/orderData/OrderData.dart';
import 'package:okapydriver/otp/otp.dart';
import 'package:okapydriver/regAddVehecle/regaddVehicle.dart';
import 'package:okapydriver/signup/signup.dart';
import 'package:okapydriver/vehicles/vehicles.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routerName: (context) => const Login(),
  SignUp.routerName: (context) => const SignUp(),
  Otp.routerName: (context) => const Otp(),
  Home.routerName: (context) => const Home(),
  Order.routerName: (context) => const Order(),
  DeliveryConfirmation.routerName: (context) => const DeliveryConfirmation(),
  OrderData.routerName: (context) => const OrderData(),
  Profile.routerName: (context) => const Profile(),
  Vehicles.routerName: (context) => const Vehicles(),
  AddVehicle.routerName: (context) => const AddVehicle(),
  RegAddVehicle.routerName: (context) => const RegAddVehicle(),
  ForgotPasswordEmail.routerName: (context) => const ForgotPasswordEmail(),
  // ChatScreen.routerName: (context) => const ChatScreen(),
  Docs.routerName: (context) => const Docs(),
  NotificationScreen.routerName: (context) => const NotificationScreen(),
};
