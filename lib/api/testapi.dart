import 'dart:io';

Future<dynamic> api(
  String method,
  String url, {
  Map<String, dynamic>? headers,
  Map<String, dynamic>? body,
}) async {
  final http = HttpClient();
  final methodUpper = method.toUpperCase();
  final uri = Uri.parse(url);
  final isMultipart = headers?['Content-type'] == 'multipart/form-data';
  try{
    final request = switch(methodUpper){
      _ => throw UnsupportedError('method error')
    };
  }finally{

  }
}
