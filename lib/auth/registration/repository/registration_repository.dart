import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRepository {
    final DatabaseReference _db = FirebaseDatabase.instance.ref('users');
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
Future<void> registerUser({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    // 1) Получаем FCM-токен устройства
    final fcmToken = await _messaging.getToken();
    if (fcmToken == null) {
      throw Exception('Не удалось получить FCM Token');
    }

    // 2) Записываем данные в Realtime Database
    final data = {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'fcmToken': fcmToken,
      'registeredAt': DateTime.now().toIso8601String(),
    };
    await _db.push().set(data);

    // 3) Сохраняем локально в SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs
      ..setString('fullName', fullName)
      ..setString('email', email)
      ..setString('phone', phone)
      ..setBool('isAuthenticated', true);


  }
}
