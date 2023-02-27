import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Controller/AboutController.dart';
class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    connectToServer();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void connectToServer() {
    try {

      // Configure socket transports must be sepecified
      socket=IO.io("http://185.190.39.86:3000",<String,dynamic>{
        "transports":["websocket"],
        "autoConnect":true
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_){
        print('connect: ${socket.id}');
      });


      // socket.on('location', handleLocationListen);
      // socket.on('typing', handleTyping);
      // socket.on('message', handleMessage);
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));

    } catch (e) {
      print(e.toString());
    }


  }
}

