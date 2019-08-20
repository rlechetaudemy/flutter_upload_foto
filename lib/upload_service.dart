import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class UploadService {
  static Future<String> upload(File file) async {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = convert.base64Encode(imageBytes);

    String fileName = path.basename(file.path);

    var headers = {"Content-Type": "application/json"};

    var params = {
      "fileName": fileName,
      "mimeType": "image/jpeg",
      "base64": base64Image
    };

    String json = convert.jsonEncode(params);

    print("http.upload >> " + json);

    final response = await http
        .post(
          "https://carros-springboot.herokuapp.com/api/v1/upload",
          body: json,
          headers: headers,
        )
        .timeout(
          Duration(seconds: 30),
          onTimeout: _onTimeOut,
        );

    print("http.upload << " + response.body);

    Map<String, dynamic> map = convert.json.decode(response.body);

    String url = map["url"];

    return url;
  }

  static FutureOr<http.Response> _onTimeOut() {
    print("timeout!");
    throw SocketException("Não foi possível se comunicar com o servidor.");
  }
}