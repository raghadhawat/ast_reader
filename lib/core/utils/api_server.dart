import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiServer {
  final baseUrl = 'https://5dfc98e59891.ngrok-free.app/api/';

  final Dio _dio;
  ApiServer(this._dio);

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({"Accept": "application/json"});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.get(
      '$baseUrl$endPoint',
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    @required dynamic body,
    String? token,
    Map<String, String>? headersfromRepo,
  }) async {
    Map<String, String> headers = {};

    headers.addAll({"Accept": "application/json"});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.post(
      '$baseUrl$endPoint',
      data: body,
      options: Options(
        headers: headersfromRepo ?? headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      'Content-Type': 'application/json',
    });
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.put(
      '$baseUrl$endPoint',
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({"Accept": "application/json"});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    var response = await _dio.delete(
      '$baseUrl$endPoint',
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> addPhoto({
    required FormData formData,
    required String endPoint,
    String? token,
  }) async {
    Map<String, String> headers = {};

    headers.addAll({'Authorization': 'Bearer $token'});

    var response = await _dio.post(
      '$baseUrl$endPoint',
      data: formData,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> patch({
    required String endPoint,
    dynamic body, // can be null, JSON map, or FormData
    String? token,
    Map<String, String>? headersfromRepo, // override if you need custom headers
  }) async {
    // Base headers
    final headers = <String, String>{
      "Accept": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await _dio.patch(
      '$baseUrl$endPoint',
      data: body,
      options: Options(headers: headersfromRepo ?? headers),
    );

    // Some PATCH endpoints return 204 (no content) -> response.data may be null
    final data = response.data;
    if (data is Map<String, dynamic>) return data;

    return response.data;
  }
  Future<Map<String, dynamic>> getWithQuery({
  required String endPoint,
  Map<String, dynamic>? query,            // optional query params
  String? token,
  Map<String, String>? headersfromRepo,   // optional header override
}) async {
  // Base headers
  final headers = <String, String>{
    "Accept": "application/json",
    if (token != null) 'Authorization': 'Bearer $token',
  };

  // Clean null/empty values so URL is tidy
  final qp = Map<String, dynamic>.from(query ?? {});
  qp.removeWhere((k, v) => v == null || (v is String && v.isEmpty));

  final response = await _dio.get(
    '$baseUrl$endPoint',
    queryParameters: qp.isEmpty ? null : qp,
    options: Options(headers: headersfromRepo ?? headers),
  );

  return response.data;
}

}
