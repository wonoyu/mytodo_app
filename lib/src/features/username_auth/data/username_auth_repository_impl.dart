import 'package:mytodo_app/src/features/username_auth/domain/username_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernameAuthRepositoryImpl implements UsernameAuthRepository {
  UsernameAuthRepositoryImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  String getUsername(String key) {
    return sharedPreferences.getString(key) ?? "User";
  }

  @override
  Future<String> setUsername(String username, String key) async {
    await sharedPreferences.setString(key, username);
    return username;
  }
}
