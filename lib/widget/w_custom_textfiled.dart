import 'package:flutter/material.dart';
import 'package:myhealthdata/util/variable.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
    required this.sufix,
  });

  final TextEditingController controller;
  final String text;
  final IconData icon;
  final String sufix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // validator : null 로 리턴 되야 통과됨. 문자열이 리턴되면 아래에 작은 빨간색 글씨로 그 글씨가 써짐
      validator: (value) {
        // ======================A L L======================
        if (value == null || value.isEmpty) {
          return '비워 둘 수 없습니다';
        }
        // =================== 로그인 / 회원가입 ===================
        // 4자 이상 Username / Passwrd // Password / Confirm Password
        if (text == 'Username' ||
            text == 'Password' ||
            text == 'Confirm Password' ||
            text == 'UserID') {
          if (value.length < 4) {
            return '$text는 4자 이상이여아 합니다';
          }
        }
        // 공백 금지 ( 띄어쓰기 ) Username
        if (text == 'Username') {
          if (value.contains(' ')) {
            return '공백은 사용할수 없습니다.';
          }
        }
        // 비밀번호 재확인 Confirm Password
        // if (text == 'Confirm Password') {
        //   if (value != signUpPasswordController.text) {
        //     return '비밀번호가 다릅니다';
        //   }
        // }
        // =================== Profile & Target ===================
        if (text == '사용자 이름' || text == '키' || text == '몸무게') {
          if (value.isEmpty) {
            return '비워둘 수 없습니다';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        suffix: Text(sufix),
        hintText: text.toString(),
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(icon, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
