class TopException {
  int code;
  Exception exception;
  String url;
  String requestBody;
  String responseBody;

  TopException({
    required this.code,
    required this.exception,
    this.url = '',
    this.requestBody = '',
    this.responseBody = '',
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {
      'message': responseBody,
      'errorCode': code,
      'exception': exception.runtimeType.toString(),
      'url': url,
      'responseBody': exception.toString(),
      'requestBody': requestBody,
    };
    return _map;
  }
}
