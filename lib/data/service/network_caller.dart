import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri);
      _logResponse(url, response);
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      _logResponse(url, response);
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, {Map<String, dynamic>? body}) {
    debugPrint(
      'URL : $url\n'
      'Body: $body',
    );
  }

  void _logResponse(String url, Response response) {
    debugPrint(
      "URL:$url\n"
      "Status Code: ${response.statusCode}\n"
      "Body: ${response.body}",
    );
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage,
  });
}
