import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mytodo_app/src/shared/api.dart';

final httpClientProvider = Provider((ref) {
  return http.Client();
});

final todoListApiProvider = Provider((ref) {
  return TodoListApi();
});
