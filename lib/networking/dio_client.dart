// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/networking/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  final Dio _dio = Dio();
  
  DioClient() {
    _dio.options
      ..baseUrl = APIEndpoints.BaseUrl
      ..connectTimeout = const Duration(seconds: 50)
      ..receiveTimeout = const Duration(seconds: 50)
      ..headers = {"content-Type": "application/json"};
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameter}) async {
    try {
      final response =
      await _dio.get(endpoint, queryParameters: queryParameter);
      // await jsonDecode(response.data.toString());

      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> post(String endpoint, {dynamic body}) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      // jsonDecode(response.data.toString());
    

      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}

final dioClientProvider = Provider<DioClient>((ref) => DioClient());
