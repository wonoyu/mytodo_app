import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UsernameAuthRepository {
  Future<String> setUsername(String username, String key);
  String getUsername(String key);
}

final usernameAuthRepositoryProvider = Provider<UsernameAuthRepository>((ref) {
  throw UnimplementedError();
});
