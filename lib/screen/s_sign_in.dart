import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhealthdata/widget/w_custom_textfiled.dart';
import '../api/api.dart';
import '../util/variable.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controller
  late final TextEditingController signInUsernameController;
  late final TextEditingController signInPasswordController;

  // 컨트롤러 초기화
  @override
  void initState() {
    super.initState();
    signInUsernameController = TextEditingController();
    signInPasswordController = TextEditingController();
  }

  // 컨트롤러 삭제
  @override
  void dispose() {
    super.dispose();
    signInUsernameController.dispose();
    signInPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        backgroundColor: Colors.black,
        title: Text(
          'MY Health DATA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/symbol.svg'),
                SizedBox(height: 35),
                Text(
                  'Please enter your information.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFiled(
                          controller: signInUsernameController,
                          text: 'Username',
                          icon: Icons.person,
                          sufix: '',
                        ),
                        SizedBox(height: 15),
                        CustomTextFiled(
                          controller: signInPasswordController,
                          text: 'Password',
                          icon: Icons.lock,
                          sufix: '',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // 로그인 API
                    print(
                      '프로필 : $getProfileInfo\n'
                      '물 : $getWaterInfo\n'
                      '스텝 : $getStepInfo',
                    );
                    print('username 입력 : $signInUsernameController.text');
                    print('password 입력 : $signInPasswordController.text');
                    if (_formKey.currentState!.validate()) {
                      final bool isOk = await apiSignIn(
                        signInUsernameController.text,
                        signInPasswordController.text,
                      );
                      if (isOk) {
                        await apiGetProfile();
                        await apiGetWater();
                        await apiGetStep();
                        Navigator.pushNamed(context, '/home');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black54,
                    fixedSize: Size(350, 50),
                  ),
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 180,
        color: CupertinoColors.systemGrey6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                style: TextButton.styleFrom(
                  fixedSize: Size(300, 40),
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  fixedSize: Size(300, 40),
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.black12),
                ),
                child: Text(
                  'Password Reset',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
