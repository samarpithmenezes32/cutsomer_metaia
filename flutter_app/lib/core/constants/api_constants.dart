// API base URL — update to your deployed backend address
class ApiConstants {
  static const String baseUrl = 'http://localhost:5000/api';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String googleAuth = '/auth/google';
  static const String forgotPassword = '/auth/forgot-password';

  // User
  static const String profile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String addresses = '/users/addresses';

  // Orders
  static const String orders = '/orders';
  static const String createOrder = '/orders';
  static const String orderDetails = '/orders/';

  // Tailors
  static const String tailors = '/tailors';
  static const String tailorDetails = '/tailors/';

  // Payments
  static const String createPayment = '/payments';
  static const String verifyPayment = '/payments/verify';

  // Notifications
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/';
  static const String markAllRead = '/notifications/read-all';

  // Measurements
  static const String saveMeasurement = '/measurements';
  static const String measurements = '/measurements';

  // Reviews
  static const String createReview = '/reviews';

  // Catalogue
  static const String categories = '/categories';
  static const String styles = '/styles';
}
