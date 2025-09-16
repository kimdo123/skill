import 'package:flutter/material.dart';
import 'dart:math';

Widget ballonTextWidget(String text, bool isTailTop) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Positioned(
        // 탑 이면 탑에서 0
        top: isTailTop ? 0 : null,
        // 탑 아니면 바텀에서 0
        bottom: isTailTop ? null : 0,
        // 회전시키는거?
        child: Transform.rotate(
          // 파이 / 4
          angle: pi / 4, // 45도 회전
          // 화살표 컨테이너
          child: Container(width: 10, height: 10, color: Colors.grey),
        ),
      ),

      Padding(
        padding: EdgeInsets.only(
          // 탑이면 위에서 5떨어진곳
          top: isTailTop ? 5 : 0,
          // 바텀이면 아래에서 5떨어진곳
          bottom: isTailTop ? 0 : 5,
        ),
        // 텍스트 들어가는 그 박스
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Padding(
            // 좌 우 여백 조절
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ],
  );
}
