import 'dart:convert';

import 'package:golive/common/constant.dart';
import 'package:http/http.dart' as http;

class RoomService {
  Future<String> getToken({
    required String userId,
    required String roomId,
    required String role,
  }) async {
    Uri endPoint = Uri.parse(Constant.prodTokenEndpoint);

    http.Response response = await http.post(endPoint, body: {
      'room_id': roomId,
      'user_id': userId,
      'role': role,
    });

    var body = json.decode(response.body);
    return body['token'];
  }
}
