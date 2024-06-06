// ignore_for_file: prefer_generic_function_type_aliases



import 'models/top_exception.dart';

typedef void OnTryLogin(
    String login, String password, int screenSuccess, int screenNoSuccess);
typedef void OnSetToken(String token);
// typedef void OnHttpSuccess({Map<String, String> headers, Map<String, dynamic> body});
// typedef void OnHttpSuccess({Map<String, String> headers, dynamic body});

typedef void OnHttpSuccess(Map<String, String> headers, dynamic body);
typedef void OnHttpError(int code, dynamic body);
typedef void OnHttpFatalError(TopException te);
// typedef void OnHttpFatalError(Exception e, [String? tel, String? url, String? body]);

typedef void OnBoolChanged(bool value);
typedef void OnChangeFilter(
    List<String> wantedFuels, List<String> wantedServices);
