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
}
