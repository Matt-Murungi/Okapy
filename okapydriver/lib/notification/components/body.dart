import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/NotificationModel.dart';
import '../../models/authmodel.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}
class _BodyState extends State<Body> {
  dynamic channel;
  String getHeadings(Duration month) {

    if(month.inDays==0)
    {
      return "Today";
    }
    else if(month.inDays>1 &&month.inDays<7)
    {
      return "This week";
    }
    else if(month.inDays>7 &&month.inDays<30)
    {
      return "This month";
    }
    else if(month.inDays>30 &&month.inDays<365)
    {
      return "This year";
    }
    else{
      return "Older Notifications";
    }
  }
  Map<String,List<NotificationModel>>data={};
  websocketSreamerInit() async {
    print('init sockets');
    final prefs = await SharedPreferences.getInstance();
    AuthModel userToken =
    AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
    channel = WebSocketChannel.connect(
      Uri.parse(
        // 'ws://apidev.okapy.world:8000/chats/${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}/?token=${userToken.key}'),
          'ws://$baseUrl:8000/notifications/?token=${userToken.key}'),
    );

    channel.stream.listen((message) {
      print("The notifications are "+message);
      Map<String,dynamic>dataMessages=jsonDecode(message);

      if(dataMessages['type']=='get_notifications')
      {
        Iterable keys = jsonDecode(message)['message'];
        List<NotificationModel>chats=keys.map((e) => NotificationModel.fromJson(e)).toList();
        List<String>titles=[];
        for(NotificationModel model in chats.reversed)
        {
          DateTime dt = DateFormat('MM/dd/yyyy HH:mm:ss').parse(model.created_at!);
          DateTime now= DateTime.now();
          String monthString = getHeadings(now.difference(dt));
          if(!titles.contains(monthString))
          {
            titles.add(monthString);
          }

        }
        for(String s in titles)
        {
          List<NotificationModel>bookingToAdd=[];
          for(NotificationModel model in chats)
          {
            DateTime dt = DateFormat('MM/dd/yyyy HH:mm:ss').parse(model.created_at!);
            DateTime now= DateTime.now();
            String monthString = getHeadings(now.difference(dt));
            if(s==monthString)
            {
              bookingToAdd.add(model);
            }

          }
          setState(() {
            data[s]=bookingToAdd;
          });
        }

        setState(() {
          _list=chats;
          isUpdated=false;
        });
      }

    });
    channel.sink.add(jsonEncode({
      "type": "get_notifications",
    }));

  }
  List<NotificationModel>_list=[];
  bool isUpdated=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    websocketSreamerInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom('Notifications'),
      backgroundColor: Colors.white,
      // body: Column(
      //   children: [
      //     Row(
      //       children: const [
      //         Padding(
      //           padding: const EdgeInsets.all(15.0),
      //           child: Text(
      //             'Today',
      //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      //           ),
      //         ),
      //       ],
      //     ),
      //     ListTile(
      //       leading: Icon(
      //         Icons.notifications,
      //         color: themeColorAmber,
      //       ),
      //       title: Text('Package successfully paid'),
      //       trailing: Text(
      //         '10 min ago',
      //         style: TextStyle(color: themeColorGrey, fontSize: 10),
      //       ),
      //     ),
      //     ListTile(
      //       leading: Icon(
      //         Icons.notifications,
      //         color: themeColorAmber,
      //       ),
      //       title: Text('Your driver has arrived '),
      //       trailing: Text(
      //         '10 min ago',
      //         style: TextStyle(color: themeColorGrey, fontSize: 10),
      //       ),
      //     ),
      //     Row(
      //       children: const [
      //         Padding(
      //           padding: const EdgeInsets.all(15.0),
      //           child: Text(
      //             'This week',
      //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      //           ),
      //         ),
      //       ],
      //     ),
      //     ListTile(
      //       leading: Icon(
      //         Icons.notifications_none_outlined,
      //         color: themeColorAmber,
      //       ),
      //       title: const Text('Your driver has arrived '),
      //       trailing: Text(
      //         '10 min ago',
      //         style: TextStyle(color: themeColorGrey, fontSize: 10),
      //       ),
      //     ),
      //     ListTile(
      //       leading: Icon(
      //         Icons.notifications_none_outlined,
      //         color: themeColorAmber,
      //       ),
      //       title: const Text('Your driver has arrived '),
      //       trailing: Text(
      //         '10 min ago',
      //         style: TextStyle(color: themeColorGrey, fontSize: 10),
      //       ),
      //     ),
      //     ListTile(
      //       leading: Icon(
      //         Icons.notifications_none_outlined,
      //         color: themeColorAmber,
      //       ),
      //       title: const Text('Your driver has arrived '),
      //       trailing: Text(
      //         '10 min ago',
      //         style: TextStyle(color: themeColorGrey, fontSize: 10),
      //       ),
      //     ),
      //     ListTile(
      //       leading: Icon(
      //         Icons.notifications_none_outlined,
      //         color: themeColorAmber,
      //       ),
      //       title: const Text('Your driver has arrived '),
      //       trailing: Text(
      //         '10 min ago',
      //         style: TextStyle(color: themeColorGrey, fontSize: 10),
      //       ),
      //     ),
      //   ],
      // ),
      body:isUpdated?Column(children: [LinearProgressIndicator()],):_list.isEmpty? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Text("No recent notifications"),
          )
        ],
      ):CustomScrollView(
        slivers: data.entries.map((e) => getListItemByMonth(e.key, e.value)).toList(),
      ),
    );
  }
  Widget listItem(NotificationModel bookingDetailsModel) {

    return ListTile(
        onTap: () {

        },
        leading:Icon(Icons.notifications),

        title: Text(
          bookingDetailsModel.txt!,
        ),
        trailing: Text(bookingDetailsModel.created_at!)
    );
  }

  Widget getListItemByMonth(String month, List<NotificationModel> listItems) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.only(left: 20,),
          child: Text(
            month,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        ...listItems.map((e) => listItem(e)).toList(),
        Container(width: 1,color: Colors.grey,)
      ]),
    );
  }
}

AppBar appBarCustom(String? title) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text('$title'),
  );
}
