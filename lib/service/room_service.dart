import 'dart:convert';

import 'package:golive/common/constant.dart';
import 'package:http/http.dart' as http;

class RoomService {
  Future<String> getToken({required String user, required String room}) async {
    Uri endPoint = Uri.parse(Constant.prodTokenEndpoint);

    http.Response response = await http.post(endPoint, body: {
      'user_id': user,
    });

    var body = json.decode(response.body);
    print(body);
    return body['token'];
  }
}
