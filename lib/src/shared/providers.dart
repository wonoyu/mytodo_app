import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mytodo_app/src/shared/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final todoListApiProvider = Provider<TodoListApi>((ref) {
  return TodoListApi();
});

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});
