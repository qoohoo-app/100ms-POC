import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Live',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> getToken({required String user, required String room, required String role}) async {
    http.Response response = await http.post(
      Uri.parse('https://prod-in.100ms.live/hmsapi/qoohoo3.app.100ms.live/'),
      body: {
        'room_id': room,
        'user_id': user,
        'role': role,
      },
    );

    var body = json.decode(response.body);
    return body['token'];
  }

  Future<void> startMeeting({
    required String role,
  }) async {
    final uid = Uuid().v1();
    final roomId = '619f2a06af3188df33e6b172';
    final token = await getToken(user: uid, room: roomId, role: role);

    HMSConfig config = HMSConfig(
      userId: uid,
      roomId: roomId,
      authToken: token,
      userName: 'Qoohoo',
    );
    HMSMeeting meeting = new HMSMeeting();
    meeting.joinMeeting(
      config: config,
      isProdLink: false,
      setWebrtcLogs: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go Live'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await startMeeting(role: 'teacher');
            },
            child: Text('Create meeting'),
          ),
          SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () async {
              await startMeeting(role: 'student');
            },
            child: Text('Join meeting'),
          ),
        ],
      ),
    );
  }
}
