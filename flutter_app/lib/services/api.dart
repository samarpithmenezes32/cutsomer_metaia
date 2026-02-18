import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String defaultApiBaseUrl = 'http://localhost:5000/api';

class AuthAPI {
  static String? _authToken;
  static String apiBaseUrl = defaultApiBaseUrl;

  static Future<void> initAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken');
  }

  static Future<void> setAuthToken(String? token) async {
    _authToken = token;
    final prefs = await SharedPreferences.getInstance();

    if (token != null) {
      await prefs.setString('authToken', token);
    } else {
      await prefs.remove('authToken');
    }
  }

  static String? getAuthToken() => _authToken;

  static Future<Map<String, dynamic>> apiCall(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    final url = Uri.parse('$apiBaseUrl$endpoint');
    http.Response response;

    switch (method) {
      case 'POST':
        response = await http.post(
          url,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
        break;
      case 'PUT':
        response = await http.put(
          url,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
        break;
      case 'DELETE':
        response = await http.delete(url, headers: headers);
        break;
      default:
        response = await http.get(url, headers: headers);
    }

    final data = jsonDecode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(data['message'] ?? 'Something went wrong');
    }

    return data;
  }

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> userData,
  ) async {
    final data = await apiCall(
      '/auth/register',
      method: 'POST',
      body: userData,
    );
    await setAuthToken(data['data']['token']);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(data['data']['user']));

    return data;
  }

  static Future<Map<String, dynamic>> login(
    Map<String, dynamic> credentials,
  ) async {
    final data = await apiCall(
      '/auth/login',
      method: 'POST',
      body: credentials,
    );
    await setAuthToken(data['data']['token']);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(data['data']['user']));

    return data;
  }

  static Future<Map<String, dynamic>> sendOTP(String phone) async {
    return await apiCall(
      '/auth/send-otp',
      method: 'POST',
      body: {'phone': phone},
    );
  }

  static Future<Map<String, dynamic>> verifyOTP(
    Map<String, dynamic> otpData,
  ) async {
    final data = await apiCall(
      '/auth/verify-otp',
      method: 'POST',
      body: otpData,
    );
    await setAuthToken(data['data']['token']);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(data['data']['user']));

    return data;
  }

  static Future<Map<String, dynamic>> resetPassword(
    Map<String, dynamic> resetData,
  ) async {
    return await apiCall(
      '/auth/reset-password',
      method: 'POST',
      body: resetData,
    );
  }

  static Future<void> logout() async {
    await setAuthToken(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('authToken');
    await prefs.remove('profileMeasurements');
    await prefs.remove('userProfile');
    await prefs.remove('profileImage');
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString('user');

    if (userStr != null) {
      return jsonDecode(userStr);
    }

    return null;
  }
}

class OrdersAPI {
  static Future<Map<String, dynamic>> create(
    Map<String, dynamic> orderData,
  ) async {
    return await AuthAPI.apiCall('/orders', method: 'POST', body: orderData);
  }

  static Future<Map<String, dynamic>> getMyOrders() async {
    return await AuthAPI.apiCall('/orders/my-orders');
  }

  static Future<Map<String, dynamic>> getById(String id) async {
    return await AuthAPI.apiCall('/orders/$id');
  }
}
