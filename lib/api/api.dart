import 'package:myhealthdata/dto/dto.dart';
import '../api/rest_api.dart';
import '../util/variable.dart';

// 토큰
final accessToken = 'ddffqwfffffffff';

// ==================== 로그인 [POST] ==================== //
Future<bool> apiSignIn(String userId, String password) async {
  try {
    final signIn = await api(
      'POST',
      'http://arkenzo.dothome.co.kr/myhealth/signin',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: {"mberId": userId, "mberPassword": password},
    );
    print('로그인 확인: $signIn');
    // bool 타입이라 리턴 해줘야됨
    return true;
  } catch (e) {
    print('에러: $e');
  }
  return false;
}

// ==================== 회원가입 [POST] ==================== //
Future<bool> apiSignUp(String userId, String username, String password) async {
  try {
    final signUp = await api(
      'POST',
      'http://arkenzo.dothome.co.kr/myhealth/signup',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
      },
      body: {"mberId": userId, "mberNm": username, "mberPassword": password},
    );
    print('회원가입 확인: $signUp');
    return true;
  } catch (e) {
    print('에러: $e');
  }
  return false;
}

// ==================== 프로필 정보 업데이트 [PUT] ==================== //
Future<void> apiPutProfile() async {
  final resultPutProfile = await api(
    'PUT',
    'http://arkenzo.dothome.co.kr/myhealth/profile',
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
    body: {
      'mberNm': nickNameController.text,
      'sexdstn': tapS,
      'height': heightController.text,
      'weight': weightController.text,
      'brthdy': birthdayController.text,
      'stepTarget': targetStepController.text,
      'waterTarget': targetWaterController.text,
    },
  );
  // 확인용
  print(resultPutProfile);
  putProfileInfo = resultPutProfile;
}

// ==================== 프로필 정보 확인 [GET] ==================== //
Future<void> apiGetProfile() async {
  try {
    final getProfile = await api(
      'GET',
      'http://arkenzo.dothome.co.kr/myhealth/profile',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    ProfileDto(
      username: getProfile['data']['mberNm'],
      height: getProfile['data']['height'],
      weight: getProfile['data']['weight'],
      brith: getProfile['data']['brthdy'],
      stepTarget: getProfile['stepTarget'],
      waterTarget: getProfile['data']['waterTarget'],
    );
    print('겟프로필 : $getProfile');
    getProfileInfo = getProfile;
  } catch (e) {
    print('에러 $e');
  }
}

// ==================== Water [GET] ==================== //
Future<void> apiGetWater() async {
  try {
    final getWater = await api(
      'GET',
      'http://arkenzo.dothome.co.kr/myhealth/water',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    // 확인용
    print('겟 워터 : $getWater');
    // 전역으로 water 현황 전달
    getWaterInfo = getWater;
  } catch (e) {
    print('에러 $e');
  }
}

// ==================== Water [POST] ==================== //
Future<void> apiPostWater(int plusWater) async {
  try {
    final postWater = await api(
      'POST',
      'http://arkenzo.dothome.co.kr/myhealth/water',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: {
        // (현제 water 현황 + 추가한 량 100 or 250) 을 보냄 / .clamp 로 최대치를 목표치로 설정. 목표 이상안되게.
        "water": (getWaterInfo['data']['water'] + plusWater).clamp(
          0,
          getProfileInfo['data']['waterTarget'],
        ),
      },
    );
    // 확인용
    print('포스트 워터 : $postWater');
    // 업데이트 한 현황을 다시 get 해옴
    await apiGetWater();
  } catch (e) {
    print('에러 $e');
  }
}

// ==================== Step [GET] ==================== //
Future<void> apiGetStep() async {
  try {
    final getStep = await api(
      'GET',
      'http://arkenzo.dothome.co.kr/myhealth/step',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    getStepInfo = getStep;
  } catch (e) {
    print('에러: $e');
  }
}

// ==================== Step [POST] ==================== //
Future<void> apiPostStep(int tmpStepStatus) async {
  try {
    final postStep = await api(
      'POST',
      'http://arkenzo.dothome.co.kr/myhealth/step',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: {
        'stepCount': tmpStepStatus.clamp(
          0,
          getProfileInfo['data']['stepTarget'],
        ),
      },
    );
  } catch (e) {
    print('에러 $e');
  }
}
