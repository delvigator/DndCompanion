

import '../type_defs.dart';
import 'http_provider.dart';

Future<void> tryGetClasses(
    {required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().getData(
      method: 'classes/getAll',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}

Future<void> tryGetRaces(
    {required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().getData(
      method: 'races/getAll',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}