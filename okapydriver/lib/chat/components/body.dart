import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okapydriver/models/authmodel.dart';
import 'package:okapydriver/models/chatNotification.dart';
import 'package:okapydriver/state/auth.dart';
import 'package:okapydriver/state/jobs.dart';
import 'package:okapydriver/utils/color.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Body extends StatefulWidget {
  final AvailableJobsController availableJobs;
  final Auth authController;
  const Body(
      {super.key, required this.availableJobs, required this.authController});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late WebSocketChannel channel;
  @override
  void initState() {
    websocketSreamerInit();
    super.initState();
  }
  ScrollController controller = new ScrollController();
  websocketSreamerInit() async {
    final prefs = await SharedPreferences.getInstance();
    AuthModel userToken =
    AuthModel.fromJson(jsonDecode(prefs.getString('token')!));
    print('init sockets ws://$baseUrl:8000/chats/${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}/?token=${userToken.key}');

    channel = WebSocketChannel.connect(
      Uri.parse(
        // 'ws://apidev.okapy.world:8000/chats/${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}/?token=${userToken.key}'),
          'ws://$baseUrl:8000/chats/${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}/?token=${userToken.key}'),
    );
    channel.sink.add(jsonEncode({
      "type": "get_messages",
    }));
    channel.stream.listen((message) {
      print("The messaget are "+message);
      Map<String,dynamic>dataMessages=jsonDecode(message);
      if(dataMessages['type']=='last_messages')
      {
        Iterable keys = jsonDecode(message)['message'];
        List<ChatNotice>chats=keys.map((e) => ChatNotice.fromJson2(e)).toList().reversed.toList();

        setState(() {
          _list=chats;
          isUpdated=false;
        });
        controller.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
        print("The size of list is ${_list.length}");
      }
      else if(dataMessages['type']=='chat_message_echo')
      {
        ChatNotice beacons =
        ChatNotice.fromJson(jsonDecode(message));
        setState(() {
          _list.add(beacons);
        });
        controller.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );

      }
      else if(dataMessages['type']=='user_join')
      {

      }

      else if(dataMessages['type']=='user_leave')
      {

      }
    });

  }

  String? text;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
   List<ChatNotice> _list = [];
  bool isUpdated=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.,
      floatingActionButton:  Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextFormField(
                      controller: _controller,
                      onSaved: (newValue) => text = newValue,
                      validator: (value) {
                        return null;
                      },
                      maxLines: 6,
                    ),
                  ),
                  Container(
                    height: 49,
                    width: 106,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeColorAmber),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _formKey.currentState?.reset();

                            if( _controller.text.isEmpty) {
                              return;
                            }

                            channel.sink.add(jsonEncode({
                              "type": "chat_message",
                              "message": _controller.text,
                              "name":
                              "${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.id}__${widget.authController.userModel?.id}"
                            }));
                            _controller.clear();
                            FocusManager.instance.primaryFocus?.unfocus();

                            // channel.sink.add(jsonEncode({
                            //   "type": "get_messages",
                            // }));
                          }
                        },
                        child: const Text('send')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          foregroundColor: themeColorGreen,
          elevation: 0,
          title: Text(
            '${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.firstName} ${widget.availableJobs.bookingsDetailsModelActive?.booking?.owner?.lastName}',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: themeColorGreen),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.phone_outlined,
                color: themeColorAmber,
              ),
            )
          ],
        ),
        body:isUpdated?Column(children: [LinearProgressIndicator()],):Padding(padding: EdgeInsets.only(bottom: 100),child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) => _list[index].message ==
              null
              ? const SizedBox()
              : _list[index].message!.receiver!.id ==
              widget.authController.userModel!.id!
              ? Column(
            children: [
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 15.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight:
                              Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight:
                              Radius.circular(10)),
                          color: Color.fromRGBO(
                              238, 238, 238, 1)),
                      width: MediaQuery.of(context)
                          .size
                          .width *
                          .5,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          '${_list[index].message!.text}'),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 5),
                      child: Text(
                        '${(_list[index].message?.createdAt)!.split(' ')[1]} ',
                        style: TextStyle(
                            fontSize: 12,
                            color: themeColorGrey),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          )
              : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 15.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.only(
                                  bottomLeft:
                                  Radius.circular(
                                      10),
                                  topLeft:
                                  Radius.circular(
                                      10),
                                  topRight:
                                  Radius.circular(
                                      10)),
                              color: Color.fromRGBO(
                                  239, 175, 29, .36)),
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              .5,
                          padding: EdgeInsets.all(10),
                          child: Text(
                              '${_list[index].message!.text}'),
                        ),
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 15.0, top: 5),
                                child: Text(
                                  '${(_list[index].message?.createdAt)!.split(' ')[1]} ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      themeColorGrey),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),));
  }
}
