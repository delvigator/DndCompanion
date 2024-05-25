import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:dnd/global_vars.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;

import '../components/constants.dart';
import '../models/top_exception.dart';
import '../type_defs.dart';


enum AuthorizationWay { none, bearer }

class HttpProvider {
  static const int tokenValidityPeriod = 3600;
  static const int kHttpTimeout = 40;
  http.Client client = http.Client();
  static const int Client_Exception_Limit = 5;
  static const int Client_Exception_Delay = 2; // in seconds

  // эту функцию используется для показа path c _copy
  String mwPath(String method) {
    return '/$method'; // _copy
  }

  Uri mwUri(String method, {String? query, Map<String, dynamic>? params}) {
    return Uri(
        scheme: 'http',
        host: '77.232.138.200',
        path: mwPath(method),
        port: 8080,
        query: query,
        queryParameters: params);
  }

  Map<String, String> mwHeaders({
    bool contentTypeJson = false,
    AuthorizationWay authorization = AuthorizationWay.none,
  }) {
    return {
      if(userData.token!='')
      HttpHeaders.authorizationHeader:
          'Bearer ${userData.token}',
      HttpHeaders.acceptHeader: 'application/json',
      if (contentTypeJson) HttpHeaders.contentTypeHeader: 'application/json',
    };
  }



  /// Все GET запросы,
  Future<void> getData(
      {required String method,
      String? query, //bool skipRenew = false,
      Map<String, String>? params,
      AuthorizationWay authorization = AuthorizationWay.none,
      required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
    http.Response? response;

    final Uri _uri = mwUri(method, query: query, params: params);
    final Map<String, String> _headers = mwHeaders(
      authorization: authorization,
    );

    debugPrint('get: $_uri');
    debugPrint('headers: $_headers');

    try {
      response = await client.get(_uri, headers: _headers).timeout(
          const Duration(seconds: kHttpTimeout),
          onTimeout: () => throw TimeoutException(kTimeoutError));
    } on Exception catch (exception) {
      onFatalError
          ?.call(TopException(code: -1, exception: exception, url: method));
    } catch (e) {
      debugPrint(e.toString());
    }

    if (response != null) {
      if (response.statusCode == 500) {
        debugPrint('body.500= ${response.body}');
      }
      if (response.statusCode == 200) {
        try {
          final String _body = utf8.decode(response.bodyBytes);
          debugPrint('utf8 body = $_body');
          final _data = json.decode(_body);
          debugPrint('_data($method) = ${_data.runtimeType}');
          onSuccess(response.headers, _data);
        } catch (e) {
          // this.body = response.body;
          debugPrint(e.toString());
          onSuccess(response.headers, response.body);
        }
      } else {
        onError?.call(response.statusCode, response.body);
      }
    }
  }

  /// Все POST запросы,
  Future<void> postData(
      {required String method,
      String? query,
      String? body,
      bool skipRenew = false,
      AuthorizationWay authorization = AuthorizationWay.none,
      required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
    http.Response? response;


    final Uri _uri = mwUri(method, query: query);
    final Map<String, String> _headers = mwHeaders(
      authorization: authorization,
    );

    debugPrint('post: $_uri');
    debugPrint('body: $body');
    //if (body != null && body.isNotEmpty) body = body.encodeStringToPipe64();
    //debugPrint('body= $body');
    debugPrint('headers: $_headers');

    int clientExceptionAttempts = 0;
    bool _ok = false;
    TopException? teClientException;

    while (!_ok) {
      _ok = true;
      try {
        response = await client
            .post(
              _uri,
              headers: _headers,
              body: body,
            )
            .timeout(
              const Duration(seconds: kHttpTimeout),
              onTimeout: () => throw TimeoutException(kTimeoutError),
            );
      } on http.ClientException catch (exception) {
        teClientException = TopException(
            code: -1 * clientExceptionAttempts - 1,
            exception: exception,
            url: method,
            requestBody: '$body');
        await Future.delayed(const Duration(seconds: Client_Exception_Delay),
            () {
          clientExceptionAttempts++;
        });
        _ok = clientExceptionAttempts >= Client_Exception_Limit;
        if (_ok) {
          onFatalError?.call(teClientException);
          // предотвращает дублирование patchData вызываемое
          // messagesOnError, и в конце этой процедуры
          teClientException = null;
        }
      } on Exception catch (exception) {
        onFatalError?.call(TopException(
            code: -1, exception: exception, url: method, requestBody: '$body'));
      } catch (e) {
        // executed for errors of all types other than Exception
        debugPrint(e.toString());
      }
    }

    if (response != null) {
      debugPrint('response.statusCode: ${response.statusCode}');
      debugPrint('response.headers: ${response.headers}');
      debugPrint('response.body: ${response.body.runtimeType}');
      if (response.statusCode == 500) {
        debugPrint('body.500= ${response.body}');
      }
      if (response.statusCode == 200) {
        dynamic _map;
        try {
          _map = json.decode(response.body);
        } catch (_) {}
        onSuccess(response.headers, _map ?? response.body);
      } else {
        // debugPrint('error.statusCode: ' + response.statusCode.toString());
        onError?.call(response.statusCode, response.body);
      }
    }
  }

  /// Все PUT запросы,
  Future<void> putData(
      {AuthorizationWay authorization = AuthorizationWay.none,
      required String method,
      String? query,
      String? body,
      required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
    http.Response? response;

    final Uri _uri = mwUri(method, query: query);
    final Map<String, String> _headers = mwHeaders(
      authorization: authorization,
    );

    debugPrint('put: $_uri');
    debugPrint('body: $body');
   // if (body != null && body.isNotEmpty) body = body.encodeStringToPipe64();
   // debugPrint('body= $body');
    debugPrint('headers: $_headers');

    try {
      response = await client
          .put(
            _uri,
            headers: _headers,
            body: body,
          )
          .timeout(
            const Duration(seconds: kHttpTimeout),
            onTimeout: () => throw TimeoutException(kTimeoutError),
          );
    } on Exception catch (exception) {
      onFatalError?.call(TopException(
          code: -1, exception: exception, url: method, requestBody: '$body'));
    } catch (e) {
      debugPrint(e.toString());
    }

    if (response != null) {
      debugPrint('response.statusCode: ${response.statusCode}');
      debugPrint('response type: ${response.body.runtimeType}');
      debugPrint('body: ${response.body}');
      if (response.statusCode == 200) {
        debugPrint('response.headers: ${response.headers}');
        try {
          final String _body = utf8.decode(response.bodyBytes);
          final _data = json.decode(_body);
          onSuccess(response.headers, _data);
        } catch (_) {
          onSuccess(response.headers, response.body);
        }
      } else {
        onError?.call(response.statusCode, response.body);
      }
    }
  }
}
