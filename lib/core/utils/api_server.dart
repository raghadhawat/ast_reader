import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiServer {
  final baseUrl = 'https://d9024ba6d1e0.ngrok-free.app/api/';

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
}
