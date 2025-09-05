import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // ✅ Enable secure options for both platforms
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true, // Enable encrypted storage for Android
    ),
    iOptions: IOSOptions(
      accessibility:
          KeychainAccessibility.first_unlock, // Secure option for iOS
    ),
  );

  // 🔐 Write Data Securely
  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  // 🔍 Read Secure Data
  Future<String?> readSecureData(String key) async {
    return await storage.read(key: key);
  }

  // ❌ Delete Secure Data
  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}
