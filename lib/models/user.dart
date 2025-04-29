// lib/models/user.dart
class User {
  final String fullName;
  final String email;
  final String phone;

  User({
    required this.fullName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap({required String fcmToken}) => {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'fcmToken': fcmToken,
        'registeredAt': DateTime.now().toIso8601String(),
      };
}
