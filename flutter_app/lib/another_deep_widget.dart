import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/data.dart';
import 'package:mqtt_client/mqtt_client.dart';

class AnotherDeepWidget extends StatefulWidget {
  @override
  _AnotherDeepWidgetState createState() => _AnotherDeepWidgetState();
}

class _AnotherDeepWidgetState extends State<AnotherDeepWidget> {

  late StreamSubscription _suscription;
  String _data = "";

  @override
  void initState() {
    super.initState();

    _suscription = ClientProvider().client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      setState(() {
        _data = 'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _suscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("SETSTATE", style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          Text(_data),
        ],
      ),
    );
  }
}
