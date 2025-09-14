import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../domain/storage/i_token_storage.dart';

@LazySingleton(as: ITokenStorage)
class TokenStorage implements ITokenStorage {
  final _storage = const FlutterSecureStorage();

  static const String _tokenKey = "auth_token";

  AndroidOptions _androidOptions() =>  AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _iosOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.unlocked,
      );

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(
      key: _tokenKey,
      value: token,
      aOptions: _androidOptions(),
      iOptions: _iosOptions(),
    );
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(
      key: _tokenKey,
      aOptions: _androidOptions(),
      iOptions: _iosOptions(),
    );
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(
      key: _tokenKey,
      aOptions: _androidOptions(),
      iOptions: _iosOptions(),
    );
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll(
      aOptions: _androidOptions(),
      iOptions: _iosOptions(),
    );
  }
}
