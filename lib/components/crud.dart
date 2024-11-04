import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch: $e");
    }
  }

  ////////////
  postRequest(String url, Map body) async {
    try {
      var response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("in crud postRequest() =========Error : ${response.statusCode}");
      }
    } catch (e) {
      print("in crud postRequest() ========= Error Catch: $e");
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    var myRequest = await request.send();

    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
      /////////////////////////////////////////////////////////////////////////////////////////////
    } else {
      print("ERROR : ${myRequest.statusCode}");
    }
  }
}
