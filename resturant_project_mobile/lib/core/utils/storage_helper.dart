import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {

  static final storage = const FlutterSecureStorage(aOptions: AndroidOptions());


  static Future saveToken(String token)async{
    await storage.write(key: 'Token', value: token);
  }

  static Future <String?>getToken()async{
    return await storage.read(key: "Token")??"";
  }


  static Future removeToken()async{
     await storage.delete(key: "Token");
  }
}