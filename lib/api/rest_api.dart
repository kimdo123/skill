import 'dart:convert';
import 'dart:io';

Future<dynamic> api(
  String method,
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  // toUpperCase : method를 대문자로 바꿔줌.
  final methodUpper = method.toUpperCase();
  // 문자열 URL 을 Uri 객체로 변환
  final uri = Uri.parse(url);
  // 회원가입 할때 multipart 로 해야함
  final isMultipart = headers?['Content-Type'] == 'multipart/form-data';
  // HTTP를 요청하는 객체 생성.
  final client = HttpClient();
  /*
      try catch finally 예외 처리 문법
      try 에 있는 코드 실행 -> 오류발생시 catch 실행 -> 다 하고 finally 실행
      오류 없을 시 try 다하고 finally 로 감
  */
  //통신시 오류날 가능성 있기 떄문에 try catch사용
  try {
    // 1. 요청 방식(POST, GET 등)에 따라 적절한 요청 객체 생성
    final reqest = switch (methodUpper) {
      'GET' => await client.getUrl(uri),
      'POST' => await client.postUrl(uri),
      'PUT' => await client.putUrl(uri),
      'DELETE' => await client.deleteUrl(uri),
      // 언더바 _ :  위 4개 말고 다른것들 이였을때. else 느낌
      // throw :이 함수를 try 문으로 감싸서 사용할 것인데.
      // apple 이딴 이상한걸 method 에 넣으면 밑에 문을 저따 던져서,
      // try 문을 에러로 만들어서 catch 로 이동하게 함.
      // UnsupportedError: 에러 처리문.
      _ => throw UnsupportedError('지원하지 않는 HTTP 메서드: $methodUpper'),
    };

    // 2. 요청 헤더 설정(Authorization, Content-Type, Custom header 등)
    // Authorization == token.
    headers?.forEach(reqest.headers.set);
    /*   //이거 축약하면 위에꺼
    if(headers != null) {
      headers.forEach((key,value){
        reqest.headers.set(key, value);
      });
    }
     */

    // 3.요청 본문(BODY) 처리
    if (body != null) {
      if (isMultipart) {
        // multipart/form-data 요청일 때.

        // ----'아무거나${DateTime.now().millisecond}'
        final boundary = '----asdfBoundary${DateTime.now().millisecond}';
        reqest.headers.set(
          HttpHeaders.contentTypeHeader,
          'multipart/form-data; boundary=$boundary',
        );
        // multipart 포맷으로 텍스트 조립.
        final buffer = StringBuffer();
        body.forEach((key, value) {
          // buffer : 대기줄
          buffer
            // 파트 구분선
            ..writeln('--$boundary\r')
            // 필드 이름
            ..writeln('content-Disposition: form-data; name="$key"\r')
            // 공백 줄
            ..writeln('\r')
            // 필드 값 (실질적인 값)
            ..writeln('$value\r');
        });
        // 마지막 구분선
        buffer.writeln('--$boundary--\r');
        //조립된 multipart 문자열을 요청에 추가
        reqest.add(utf8.encode(buffer.toString()));
      } else {
        // JSON 요청일 때.
        reqest.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
        // .encode 앞에 있는 형식으로 뒤에 있는걸 불러오는거
        // ex) json.encode(body) body 를 json 형식으로.
        reqest.add(utf8.encode(json.encode(body))); // JSON 문자열로 변환
      }
    }
    // ===================== 4. 응답 수신 =====================
    final response = await reqest.close(); // 요청 보내고 응답 받기 (.close == 보내는거)
    final resBody = await response.transform(utf8.decoder).join(); // 응답 본문 디코딩
    // .statusCode :  응답을 받으면 200~300 번 ( 에러나면 404 뜨는 그 숫자 )
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        // 응답이 JSON 이면 파싱해서 반환
        return json.decode(resBody);
      } catch (_) {
        // JSON 아니면 문자열 그대로 반환
        return resBody;
      }
    } else {
      throw HttpException('오류: ${response.statusCode}: $resBody');
    }
  } finally {
    client.close();
  }
}
