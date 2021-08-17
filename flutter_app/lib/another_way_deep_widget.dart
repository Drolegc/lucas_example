import 'package:flutter/material.dart';
import 'package:flutter_app/data.dart';
import 'package:mqtt_client/mqtt_client.dart';

class AnotherWayDeepWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "WITH STREAMBUILDER",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
            stream: ClientProvider().client.updates,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("WITHOUT CONNECTION");
                case ConnectionState.waiting:
                  return Text("WAITING");
                case ConnectionState.active:
                case ConnectionState.done:

                  final c = snapshot.data;
                  final recMess = c![0].payload as MqttPublishMessage;
                  final pt = MqttPublishPayload.bytesToStringAsString(
                      recMess.payload.message);

                  return Text(
                      "EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->");
              }
            },
          ),
        ],
      ),
    );
  }
}
