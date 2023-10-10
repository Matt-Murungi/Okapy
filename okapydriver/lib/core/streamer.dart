import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:okapydriver/models/authmodel.dart';
import 'package:okapydriver/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketSreamer {
  dynamic channel;
  WebsocketSreamer() {
    print('streamer');
    websocketSreamerInit();
  }

  websocketSreamerInit() async {
    print('init sockets');
    final prefs = await SharedPreferences.getInstance();
    AuthModel userToken =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://$baseUrl:8000/notifications/?token=${userToken.key}'),
    );

    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        print(snapshot.data);
        print('snapshot');
        return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );
  }

  websocketSreamerInitCHat() async {
    print('init sockets');
    final prefs = await SharedPreferences.getInstance();
    AuthModel userToken =
        AuthModel.fromJson(jsonDecode(prefs.getString('token')!));

    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://apidev.okapy.world:8000/notifications/?token=${userToken.key}'),
    );

    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        print(snapshot.data);
        print('snapshot');
        return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );
  }

  clearChannel() {
    return channel.sink.close();
  }
}

class StreamProvider {
  StreamController controller = StreamController();
  Stream? stream;
  StreamProvider() {
    stream = controller.stream;
  }
}
