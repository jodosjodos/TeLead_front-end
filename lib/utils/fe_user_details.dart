import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> getUserAccountDetails({
  required String token,
  required String userId,
}) async {
  await dotenv.load();
  String? baseUrl = dotenv.env['API_URL'];

  if (baseUrl == null) {
    throw Exception("BASE_URL is not set in .env file");
  }

  String url = '$baseUrl/user/account/$userId';
  final Dio dio = Dio(
    BaseOptions(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    ),
  );

  try {
    final res = await dio.get(url);

    if (res.statusCode == 200) {
      final Map<String, dynamic> user = res.data;
      return user;
    } else {
      throw Exception('Failed to load user account details: ${res.statusCode}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      throw Exception(
          'Error: ${e.response?.statusCode} ${e.response?.statusMessage}');
    } else {
      throw Exception('Error: ${e.message}');
    }
  } catch (e) {
    throw Exception('Unexpected error: $e');
  }
}
