import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

enum SecureKeys { accessToken, refreshToken }

@lazySingleton
class SecureStorageManager {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    aOptions: AndroidOptions(
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
    ),
  );

  ///* Access Token
  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(
      key: SecureKeys.accessToken.name,
      value: accessToken,
    );
  }

  Future<String?> getAccessToken() async {
    return _secureStorage.read(key: SecureKeys.accessToken.name);
  }

  Future<void> removeAccessToken() async {
    await _secureStorage.delete(key: SecureKeys.accessToken.name);
  }

  ///* Refresh Token
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(
      key: SecureKeys.refreshToken.name,
      value: refreshToken,
    );
  }

  Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: SecureKeys.refreshToken.name);
  }

  Future<void> removeRefreshToken() async {
    await _secureStorage.delete(key: SecureKeys.refreshToken.name);
  }
}
