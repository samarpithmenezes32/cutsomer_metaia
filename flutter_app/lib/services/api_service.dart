import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';

/// HTTP wrapper using the `http` package (already in pubspec.yaml).
class ApiService {
  static String? _token;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
  }

  static Future<void> setToken(String? token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString('auth_token', token);
    } else {
      await prefs.remove('auth_token');
    }
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  Uri _uri(String path, [Map<String, String?>? query]) {
    final base = Uri.parse(ApiConstants.baseUrl + path);
    if (query == null) return base;
    final cleaned = {
      for (final e in query.entries)
        if (e.value != null) e.key: e.value!,
    };
    return base.replace(queryParameters: cleaned.isEmpty ? null : cleaned);
  }

  Future<Map<String, dynamic>> _send(http.Response res) async {
    if (res.statusCode == 401) await ApiService.setToken(null);
    return {
      'statusCode': res.statusCode,
      'data': res.body.isNotEmpty ? jsonDecode(res.body) : null,
    };
  }

  // Auth APIs
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(_uri(ApiConstants.login),
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}));
    return _send(res);
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final res = await http.post(_uri(ApiConstants.register),
        headers: _headers, body: jsonEncode(data));
    return _send(res);
  }

  Future<Map<String, dynamic>> googleAuth(String idToken) async {
    final res = await http.post(_uri(ApiConstants.googleAuth),
        headers: _headers, body: jsonEncode({'idToken': idToken}));
    return _send(res);
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final res = await http.post(_uri(ApiConstants.forgotPassword),
        headers: _headers, body: jsonEncode({'email': email}));
    return _send(res);
  }

  // User APIs
  Future<Map<String, dynamic>> getProfile() async {
    final res = await http.get(_uri(ApiConstants.profile), headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final res = await http.put(_uri(ApiConstants.updateProfile),
        headers: _headers, body: jsonEncode(data));
    return _send(res);
  }

  Future<Map<String, dynamic>> getAddresses() async {
    final res = await http.get(_uri(ApiConstants.addresses), headers: _headers);
    return _send(res);
  }

  // Order APIs
  Future<Map<String, dynamic>> getOrders({String? status}) async {
    final res = await http.get(
        _uri(ApiConstants.orders, {'status': status}),
        headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> createOrder(
      Map<String, dynamic> orderData) async {
    final res = await http.post(_uri(ApiConstants.createOrder),
        headers: _headers, body: jsonEncode(orderData));
    return _send(res);
  }

  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    final res = await http.get(
        _uri('${ApiConstants.orderDetails}$orderId'),
        headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    final res = await http.put(
        _uri('${ApiConstants.orderDetails}$orderId/cancel'),
        headers: _headers);
    return _send(res);
  }

  // Tailor APIs
  Future<Map<String, dynamic>> getTailors({
    String? specialization,
    double? minRating,
  }) async {
    final res = await http.get(
        _uri(ApiConstants.tailors, {
          'specialization': specialization,
          'minRating': minRating?.toString(),
        }),
        headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> getTailorDetails(String tailorId) async {
    final res = await http.get(
        _uri('${ApiConstants.tailorDetails}$tailorId'),
        headers: _headers);
    return _send(res);
  }

  // Payment APIs
  Future<Map<String, dynamic>> createPayment(
      String orderId, double amount) async {
    final res = await http.post(_uri(ApiConstants.createPayment),
        headers: _headers,
        body: jsonEncode({'orderId': orderId, 'amount': amount}));
    return _send(res);
  }

  Future<Map<String, dynamic>> verifyPayment(
      Map<String, dynamic> paymentData) async {
    final res = await http.post(_uri(ApiConstants.verifyPayment),
        headers: _headers, body: jsonEncode(paymentData));
    return _send(res);
  }

  // Notification APIs
  Future<Map<String, dynamic>> getNotifications() async {
    final res =
        await http.get(_uri(ApiConstants.notifications), headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> markNotificationAsRead(
      String notificationId) async {
    final res = await http.put(
        _uri('${ApiConstants.markAsRead}$notificationId/read'),
        headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> markAllNotificationsAsRead() async {
    final res =
        await http.put(_uri(ApiConstants.markAllRead), headers: _headers);
    return _send(res);
  }

  // Measurement APIs
  Future<Map<String, dynamic>> saveMeasurement(
      Map<String, dynamic> measurementData) async {
    final res = await http.post(_uri(ApiConstants.saveMeasurement),
        headers: _headers, body: jsonEncode(measurementData));
    return _send(res);
  }

  Future<Map<String, dynamic>> getMeasurements() async {
    final res =
        await http.get(_uri(ApiConstants.measurements), headers: _headers);
    return _send(res);
  }

  // Review APIs
  Future<Map<String, dynamic>> createReview(
      Map<String, dynamic> reviewData) async {
    final res = await http.post(_uri(ApiConstants.createReview),
        headers: _headers, body: jsonEncode(reviewData));
    return _send(res);
  }

  // Categories & Styles
  Future<Map<String, dynamic>> getCategories() async {
    final res =
        await http.get(_uri(ApiConstants.categories), headers: _headers);
    return _send(res);
  }

  Future<Map<String, dynamic>> getStyles() async {
    final res = await http.get(_uri(ApiConstants.styles), headers: _headers);
    return _send(res);
  }
}
