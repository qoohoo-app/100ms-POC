import 'package:flutter/material.dart';
import 'package:golive/common/constant.dart';
import 'package:golive/preview/preview_page.dart';
import 'package:golive/service/room_service.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
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
  void getPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    while ((await Permission.camera.isDenied)) {
      await Permission.camera.request();
    }
    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermissions();
  }

  Future<void> startMeeting({required String role}) async {
    final userId = Uuid().v1();
    final roomId = Constant.roomID;

    String token = await RoomService().getToken(
      userId: userId,
      roomId: roomId,
      role: role,
    );

    HMSConfig config = HMSConfig(
      userId: userId,
      roomId: roomId,
      authToken: token,
      userName: 'Qoohoo',
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PreviewPage(
          roomId: roomId,
          config: config,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go Live'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                ///Can change template/role using 100ms dashboard
                //teacher ==> creator
                await startMeeting(role: 'teacher');
              },
              child: Text('Create meeting'),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () async {
                //student ==> member
                await startMeeting(role: 'student');
              },
              child: Text('Join meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
