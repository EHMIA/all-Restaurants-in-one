import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static const String _tokenKey = 'Token';
  static const String _userIdKey = 'userId';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';
  static const String _userPhoneKey = 'userPhone';
  static const String _userAddressKey = 'userAddress';
  static const String _userPictureKey = 'userPicutre';
  static const String _userCreatedAtKey = 'userCreatedAt';

  static final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );

  static Future<void> saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }

  static Future<void> removeToken() async {
    await storage.delete(key: _tokenKey);
  }

  static Future<void> saveUserId(String id) async {
    await storage.write(key: _userIdKey, value: id);
  }

  static Future<String?> getUserId() async {
    return await storage.read(key: _userIdKey);
  }

  static Future<void> saveUserData({
    required String name,
    required String email,
    required String phone,
    required String address,
    String? createdAt,
    String? profilePic,
  }) async {
    await storage.write(key: _userNameKey, value: name);
    await storage.write(key: _userEmailKey, value: email);
    await storage.write(key: _userPhoneKey, value: phone);
    await storage.write(key: _userAddressKey, value: address);
    await storage.write(key: _userPictureKey, value: profilePic);
    await storage.write(key: _userCreatedAtKey, value: createdAt);
  }

  static Future<Map<String, String>> getUserData() async {
    return {
      'name': await storage.read(key: _userNameKey) ?? '',
      'email': await storage.read(key: _userEmailKey) ?? '',
      'phone': await storage.read(key: _userPhoneKey) ?? '',
      'address': await storage.read(key: _userAddressKey) ?? '',
      
    };
  }

  static Future<void> clearAll() async {
    await storage.deleteAll();
  }
// for add image
  static const String _profileImageKey = 'profileImagePath';

  static Future<void> saveProfileImagePath(String path) async {
    await storage.write(key: _profileImageKey, value: path);
  }

  static Future<String?> getProfileImagePath() async {
    return await storage.read(key: _profileImageKey);
  }
}
