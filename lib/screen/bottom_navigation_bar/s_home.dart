import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhealthdata/api/api.dart';
import 'package:myhealthdata/util/variable.dart';
import 'dart:math';

import 'package:myhealthdata/widget/w_baloon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bmi 선언만
  late double bmi;

  @override
  void initState() {
    super.initState();
    // bmi 구하기
    // pow (A, B) : A 값을 B번 만큼 곱하기 (제곱)
    // A.toStringAsFixed(B) : A 값을 소수점 B 자리까지 반올림 처리 후 문자로
    bmi =
        getProfileInfor['data']['weight'] /
        pow(getProfileInfor['data']['height'] * 0.01, 2);
    // water 현황 초기화
    getWaterInfor?['data']?['water'] = 0;
    // step 현황 초기화
    getStepInfor?['data']?['step'] = 0;
    // Steps 랜덤 수
    StepPlusRandom();
    print(getProfileInfor);
  }

  // 걸음수 현황 + 랜덤 더한거 저장하는거
  int tmpStepStatus = 0;

  /*
  걸음수 3초 마다 채워지는 함수
   */
  Future<void> StepPlusRandom() async {
    // while : 걸음수 현황이 목표모다 작으면 계속 실행. 아니면 빠짐.
    while (getStepInfor['data']['step'] <
        getProfileInfor['data']['stepTarget']) {
      // 3초 대기
      await Future.delayed(Duration(seconds: 3));
      // 랜덤 숫자 0~10 생성
      int random = Random().nextInt(11);
      // 걸음 현황 + 랜덤 수
      tmpStepStatus = getStepInfor['data']['step'] + random;
      // 현황 업데이트
      await PostStep(tmpStepStatus);
      // 현황 업데이트 된거 가져오기
      await GetStep();
      // 화면 새로고침
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // 오른쪽 위에 ... 버튼
          PopupMenuButton(
            style: ButtonStyle(
              // ... 이 아이콘 색
              iconColor: WidgetStateProperty.all(Colors.white),
            ),
            onSelected: (value) {
              // 선택된 항목에 따라 동작되는 부분
              if (value == 'SignOut') {
                print('로그아웃');
                Navigator.pushNamed(context, '/signIn');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                // value : 눌렀을 때 전달 할 값
                value: 'SignOut',
                // 실제로 보이는 거
                child: Text('Sign-out'),
              ),
            ],
          ),
        ],
        title: Text(
          'My Health DATA',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Hello {mberNm}
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hello ${getProfileInfor['data']['mberNm']},',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 370,
                      height: 160,
                      child: Row(
                        children: [
                          getProfileInfor['data']['sexdstn'] == 'M'
                              ? Icon(Icons.man, size: 100)
                              : Icon(Icons.woman, size: 100),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // 키 / Cm
                                    Column(
                                      children: [
                                        Text(
                                          getProfileInfor['data']['height']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Cm',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // 그냥 줄
                                    Container(
                                      width: 2,
                                      height: 60,
                                      color: Colors.grey,
                                    ),
                                    // 몸무게 / Kg
                                    Column(
                                      children: [
                                        Text(
                                          getProfileInfor['data']['weight']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Kg',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // 그냥 줄
                                    Container(
                                      width: 2,
                                      height: 60,
                                      color: Colors.grey,
                                    ),
                                    // bmi
                                    Column(
                                      children: [
                                        Text(
                                          // bmi 계산 후 .toStringAsFixed로 소수 반올림 String 변환
                                          bmi.toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'bmi',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // 그라데이션 바
                                GrapgWidgetBmi(bmi),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Steps
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Steps', style: TextStyle(fontSize: 30)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 370,
                      height: 90,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(width: 10),
                            // 현재/목표 Steps
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 현재 수치
                                Text(
                                  getStepInfor['data']['step'].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // 목표 수치
                                Text(
                                  '/${getProfileInfor['data']['stepTarget'].toString()} Steps',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            // Steps 그래프
                            GrapgWidgetSteps(getStepInfor['data']['step']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                /// Heart Rate
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Heart Rate', style: TextStyle(fontSize: 30)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 370,
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            width: 70,
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(17),
                              child: SvgPicture.asset('assets/heartrate.svg'),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '118 bpm',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // 버튼 크기
                              Container(
                                height: 35,
                                width: 120,
                                // 버튼 스타일
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(),
                                  ),
                                  // Measure 버튼
                                  onPressed: () {
                                    print('bpm 변경');
                                  },
                                  // Muasure
                                  child: Text(
                                    'Measure',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GrapgWidgetHeartRate(),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Foods
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Foods', style: TextStyle(fontSize: 30)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 370,
                      height: 90,
                    ),
                  ],
                ),

                /// Water
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Water', style: TextStyle(fontSize: 30)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 370,
                      height: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            width: 70,
                            height: 70,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset('assets/water.svg'),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    getWaterInfor['data']['water'].toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' / ${getProfileInfor['data']['waterTarget']} ml',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    // 100ml 추가
                                    ElevatedButton(
                                      onPressed: () async {
                                        // 목표량 = 현황 << 맞으면 더이상 api 요청 X
                                        if (getWaterInfor['data']['water'] !=
                                            getProfileInfor['data']['waterTarget']) {
                                          // 물 업데이트. 파라미터로 100 보내기
                                          await PostWater(100);
                                          // 화면 업데이트
                                          setState(() {});
                                        }
                                        // 확인용
                                        print('물 최대치');
                                      },
                                      // .styleFrom 은 스타일 쉽게 넣으라고 만든거.
                                      // ElevareButton 스타일을 그대로 가져온 뒤 덧붙이는거.
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: Text(
                                        '+ 100ml',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // 250ml 추가
                                    ElevatedButton(
                                      // 위에 참고
                                      onPressed: () async {
                                        if (getWaterInfor['data']['water'] !=
                                            getProfileInfor['data']['waterTarget']) {
                                          await PostWater(250);
                                          setState(() {});
                                        } else {
                                          print('물 최대치');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      child: Text(
                                        '+ 250ml',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // 컵 아이콘
                          Container(
                            /*
                            영역 확인용
                            color: Colors.grey,
                            */
                            width: 50,
                            height: 70,
                            child: SvgPicture.asset('assets/cup.svg'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  ==========================BMI 그라데이션 바==========================
   */
  Widget GrapgWidgetBmi(double bmi) {
    final value = double.parse(bmi.toStringAsFixed(2));
    return Container(
      width: 230,
      // 전체적인 레이아웃
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 전체 가로 길이
          final barWidth = constraints.maxWidth;
          // 최소 최대값
          final clampedValue = ((value - 10) / (60 - 10)).clamp(0.0, 1.0);
          // 말풍선 위치
          final position = clampedValue * barWidth; // 실제 말풍선 위치
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    // 그라데이션 바
                    Container(
                      width: barWidth,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // 그라데이션
                        gradient: LinearGradient(
                          colors: [
                            //왼쪽부터 그라데이션
                            Colors.blue,
                            Colors.green,
                            Colors.yellow,
                            Colors.orange,
                            Colors.red,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    // 하얀색 선 (표시선)
                    Positioned(
                      left: position,
                      top: 0,
                      bottom: 40,
                      child: Container(width: 2, color: Colors.white),
                    ),
                    // 말풍선
                    Positioned(
                      left: position,
                      top: 25,
                      // 자기 자신의 크기에 비례해서 이동
                      child: FractionalTranslation(
                        // 자신의 반 만큼 왼쪽으로 이동
                        translation: Offset(-0.5, 0),
                        // 말풍선 위젯
                        child: ballonTextWidget(bmi.toStringAsFixed(2), true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /*
  ========================== 걸음수 바 ==========================
   */
  Widget GrapgWidgetSteps(int stepStatus) {
    return Container(
      width: 230,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth;
          final clampedValue =
              ((stepStatus) / (getProfileInfor['data']['stepTarget'])).clamp(
                0.0,
                1.0,
              );
          final position = clampedValue * barWidth; // 실제 말풍선 위치
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    // 배경 바
                    Positioned(
                      top: 25,
                      child: Container(
                        width: barWidth,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // 초록색 게이지
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.zero,
                                bottomRight: Radius.zero,
                              ),
                            ),
                            // height: 20,
                            width: position,
                          ),
                        ),
                      ),
                    ),
                    // 진행 되는 바 // (흰색 선)
                    Positioned(
                      // 진행량 과 똑같아야됨
                      left: position,
                      // 그냥 높이 똑같이 맞추는거
                      top: 25,
                      bottom: 15,
                      child: Container(width: 2, color: Colors.white),
                    ),
                    //
                    Positioned(
                      left: position,
                      top: 0,
                      child: FractionalTranslation(
                        translation: Offset(-0.5, 0),
                        child: ballonTextWidget(
                          '${(clampedValue * 100).toStringAsFixed(0)}%',
                          false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /*
  ========================== BPM 바 ==========================
   */
  Widget GrapgWidgetHeartRate() {
    return Container(
      width: 140,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 그래프 전체 가로폭
          final barWidth = constraints.maxWidth;
          // MAX BPM TODO 60자리에 BPM 최소값 넣기
          final maxClampedValue = (170 / 200).clamp(0.0, 1.0);
          // LOW BPM TODO 120 자리에 BPM 최대값 넣기
          final lowClampedValue = (50 / 200).clamp(0.0, 1.0);
          // 말풍선 위치
          final position = ((maxClampedValue - lowClampedValue)) * barWidth;
          return Column(
            children: [
              // 전체적인 박스
              SizedBox(
                // 말풍선 까지 생각하는 높이
                height: 60,
                child: Stack(
                  children: [
                    // 배경 바 (회색)
                    Positioned(
                      top: 40,
                      child: Container(
                        // 전체길이
                        width: barWidth,
                        // 바 자체 높이
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // 초록색 게이지 바
                        child: Align(
                          // 가운데 왼쪽으로 정렬
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              // 앞에 비어있는 부분. 최소값 까지.
                              Container(
                                // 최소 bpm
                                width: lowClampedValue * barWidth,
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.green),
                                width: position,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // 말풍선
                    Positioned(
                      left: (position / 2) + (lowClampedValue * barWidth),
                      top: 10,
                      // TODO 이거 설명 쓰기
                      child: FractionalTranslation(
                        translation: Offset(-0.5, 0),
                        child: ballonTextWidget(
                          // 최소 - 최대 텍스트
                          '${(lowClampedValue * 200).toStringAsFixed(0)} - ${(maxClampedValue * 200).toStringAsFixed(0)}',
                          false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('0'), Text('200')],
              ),
            ],
          );
        },
      ),
    );
  }
}
