import 'package:flutter/material.dart';
import 'package:okapy/models/BookingsDetailsModel.dart';
import 'package:okapy/models/userModel.dart';

import 'package:provider/provider.dart';

// import 'package:okapydriver/addvehicle/components/body.dart';
import '../models/active_model.dart';
import './components/body.dart';

class ChatScreen extends StatefulWidget {
  final String routerName = 'chat';

  const ChatScreen({Key? key, this.driver, required this.userModel, required this.bookingDetailsModel});
  final Driver? driver;
  final UserModel userModel;
  final BookingDetailsModel bookingDetailsModel;

  @override
  State<ChatScreen> createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Body(driver: widget.driver!, userModel: widget.userModel, bookingDetailsModel: widget.bookingDetailsModel,

    );
  }
}
