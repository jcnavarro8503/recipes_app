import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:recipes_app/core/index.dart';

class ApiHandler {
  ///Returns the common headers.
  Future<Map<String, String>> commonHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  ///Get custome url.
  Future<http.Response> getCustomeUrl({String url = ''}) async {
    final uri = Uri.parse(url);
    final headers = await commonHeaders();

    debugPrint("-> GET-CUSTOME-URL");
    debugPrint("-> GET: $url");
    debugPrint("-> HEADERS: $headers");
    final res = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw TimeOutFailure(),
        );
    debugPrint("<- RESPONSE CODE: ${res.statusCode}");
    debugPrint("<- RESPONSE BODY: ${res.body}");

    return await handleResponse(response: res);
  }

  ///Get operations.
  Future<http.Response> get({
    String path = '',
    String params = '',
  }) async {
    final url = ApiEndpoints.baseApiEndpoint + path + params;
    final uri = Uri.parse(url);
    final headers = await commonHeaders();

    debugPrint("-> GET");
    debugPrint("-> GET: $url");
    debugPrint("-> HEADERS: $headers");
    final res = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw TimeOutFailure(),
        );
    debugPrint("<- RESPONSE CODE: ${res.statusCode}");
    debugPrint("<- RESPONSE BODY: ${res.body}");

    return await handleResponse(response: res);
  }

  ///Post operations.
  Future<http.Response> post({
    String path = '',
    String params = '',
    dynamic body = "",
  }) async {
    final url = ApiEndpoints.baseApiEndpoint + path + params;
    final uri = Uri.parse(url);
    final headers = await commonHeaders();

    debugPrint("-> POST");
    debugPrint("-> POST: $url");
    //debugPrint("-> HEADERS: $headers");
    debugPrint("-> BODY: $body");
    final res = await http.post(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw TimeOutFailure(),
        );
    debugPrint("<- RESPONSE CODE: ${res.statusCode}");
    debugPrint("<- RESPONSE BODY: ${res.body}");

    return await handleResponse(response: res);
  }

  ///Put operations.
  Future<http.Response> put({
    String path = '',
    String params = '',
    dynamic body,
  }) async {
    final url = ApiEndpoints.baseApiEndpoint + path + params;
    final uri = Uri.parse(url);
    final headers = await commonHeaders();

    debugPrint("-> PUT");
    debugPrint("-> PUT: $url");
    //debugPrint("-> HEADERS: $headers");
    debugPrint("-> BODY: $body");
    final res = await http.put(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw TimeOutFailure(),
        );
    debugPrint("<- RESPONSE CODE: ${res.statusCode}");
    debugPrint("<- RESPONSE BODY: ${res.body}");

    return await handleResponse(response: res);
  }

  ///Delete operations.
  Future<http.Response> delete({
    String path = '',
    String params = '',
  }) async {
    final url = ApiEndpoints.baseApiEndpoint + path + params;
    final uri = Uri.parse(url);
    final headers = await commonHeaders();

    debugPrint("-> DELETE");
    debugPrint("-> DELETE: $url");
    //debugPrint("-> HEADERS: $headers");
    final res = await http.delete(uri, headers: headers).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw TimeOutFailure(),
        );
    debugPrint("<- RESPONSE CODE: ${res.statusCode}");
    debugPrint("<- RESPONSE BODY: ${res.body}");

    return await handleResponse(response: res);
  }

  ///Handle response codes.
  Future<http.Response> handleResponse({
    required http.Response? response,
  }) async {
    switch (response!.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 202:
        return response;
      case 400:
        throw BadRequestFailure();
      case 401:
        throw UnauthorizedFailure();
      case 403:
        throw ForbidenFailure();
      case 404:
        throw NotFoundFailure();
      case 408:
        throw TimeOutFailure();
      case 500:
        throw ServerFailure();
      default:
        throw UnknownFailure();
    }
  }
}
