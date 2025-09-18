import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhealthdata/api/api.dart';
import 'package:myhealthdata/widget/w_custom_textfiled.dart';
import '../util/variable.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controller
  late final TextEditingController signUpUserNameController; // mberId
  late final TextEditingController signUpUserIdController; // mberNm
  late final TextEditingController signUpPasswordController; // mberPassword
  late final TextEditingController signUpConfirmPasswordController; // x

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    signUpUserNameController = TextEditingController();
    signUpUserIdController = TextEditingController();
    signUpPasswordController = TextEditingController();
    signUpConfirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    signUpUserNameController.dispose();
    signUpUserIdController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/signIn');
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 470,
                  child: Text(
                    'Your information,',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 450,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // UserID 필드 / mberId
                        CustomTextFiled(
                          controller: signUpUserIdController,
                          text: 'UserID',
                          icon: Icons.person,
                          sufix: '',
                        ),
                        SizedBox(height: 15),

                        // Username 필드 / mberNm
                        CustomTextFiled(
                          controller: signUpUserNameController,
                          text: 'Username',
                          icon: Icons.badge_outlined,
                          sufix: '',
                        ),
                        SizedBox(height: 15),

                        // Password 필드 / mberPassword
                        CustomTextFiled(
                          controller: signUpPasswordController,
                          text: 'Password',
                          icon: Icons.lock,
                          sufix: '',
                        ),
                        SizedBox(height: 15),

                        // rePassword 필드 / 패스워드 확인
                        CustomTextFiled(
                          controller: signUpConfirmPasswordController,
                          text: 'Confirm Password',
                          icon: Icons.lock_reset,
                          sufix: '',
                        ),
                        SizedBox(height: 40),

                        //  Sign Up 버튼
                        ElevatedButton(
                          onPressed: () async {
                            // 유효성 검사
                            if (_formKey.currentState?.validate() ?? false) {
                              // signUp API / 회원가입 APIap
                              final bool isOk = await apiSignUp(
                                signUpUserIdController.text,
                                signUpUserNameController.text,
                                signUpPasswordController.text,
                              );
                              if (isOk) {
                                await apiGetProfile();
                                Navigator.pushNamed(
                                  context,
                                  '/profileAndTarget',
                                );
                              } else {
                                print('중복 아이디');
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
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      /*
      ==================아래 버튼==================
       */
      bottomNavigationBar: Container(
        height: 180,
        color: CupertinoColors.systemGrey6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // sign in 버튼
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                style: TextButton.styleFrom(
                  fixedSize: Size(300, 40),
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.black12),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Password Reset 버튼
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
