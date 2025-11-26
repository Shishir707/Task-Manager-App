import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/UI/controller/auth_controller.dart';
import 'package:task_manager/app.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? "",
        },
      );
      _logResponse(url, response);
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodeData,
        );
      } else if (response.statusCode == 401) {
        await AuthController.clearCache();
        _onUnauthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: "Un-Authorize",
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

  static Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? "",
        },
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
      } else if (response.statusCode == 401) {
        await AuthController.clearCache();
        _onUnauthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: "Un-Authorize",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodeData['data'],
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

  static void _onUnauthorize() async {
    Navigator.pushNamed(
      TaskManagerApp.navigatorKey.currentContext!,
      "/sign-in",
    );
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    debugPrint(
      'URL : $url\n'
      'Body: $body',
    );
  }

  static void _logResponse(String url, Response response) {
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
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage = "Something Went wrong!",
  });
}
