import 'package:mytodo_app/src/constants/api_constants.dart';

class TodoListApi {
  Uri listNotYet() => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epGetNotYet}",
      );

  Uri listDone() => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epGetDone}",
      );

  Uri addList() => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epAdd}",
      );

  Uri updateDone(int id) => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epUpdateDone}/$id",
      );

  Uri updateNotYet(int id) => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epUpdateNotYet}/$id",
      );

  Uri deleteTodo(int id) => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epDelete}/$id",
      );

  Uri updateTextTodo(int id) => Uri(
        scheme: "https",
        host: ApiConstants.baseUrl,
        path: "${ApiConstants.path}${ApiConstants.epUpdate}/$id",
      );
}
