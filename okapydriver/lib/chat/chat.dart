import 'package:flutter/material.dart';
import 'package:okapydriver/models/availableJobs.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:provider/provider.dart';

// import 'package:okapydriver/addvehicle/components/body.dart';
import './components/body.dart';

class ChatScreen extends StatefulWidget {
  final String routerName = 'chat';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableJobsController>(
        builder: (context, availableJobs, child) => Consumer<Auth>(
              builder: (context, authController, child) => Body(
                availableJobs: availableJobs,
                authController: authController,
              ),
            ));
  }
}
