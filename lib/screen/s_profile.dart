import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhealthdata/api/api.dart';
import 'package:myhealthdata/util/variable.dart';
import 'package:myhealthdata/widget/w_custom_textfiled.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signIn');
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Profile & Target',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Hi User', style: TextStyle(fontSize: 34)),
                        SizedBox(height: 10),
                        Text(
                          '   Profile,',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // 남자 여자 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Male 버튼
                      Container(
                        width: 130,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70,
                          border: Border.all(
                            color: tapS == 'M' ? Colors.black : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print('Male');
                            setState(() {
                              tapS = 'M';
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.man, size: 100),
                              Text('Male'),
                            ],
                          ),
                        ),
                      ),

                      // Female 버튼
                      Container(
                        width: 130,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70,
                          border: Border.all(
                            color: tapS == 'G' ? Colors.black : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print('Girl');
                            setState(() {
                              tapS = 'G';
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.woman, size: 100),
                              Text('Female'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // 사용자 기본 정보 입력
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        CustomTextFiled(
                          controller: nickNameController,
                          text: (getProfileInfo['data']['mberNm'] ?? '사용자 이름').toString(),
                          icon: Icons.person,
                          sufix: '',
                        ),
                        SizedBox(height: 10),
                        CustomTextFiled(
                          controller: heightController,
                          text: (getProfileInfo['data']['height'] ?? '키').toString(),
                          icon: Icons.star,
                          sufix: 'cm',
                        ),
                        SizedBox(height: 10),
                        CustomTextFiled(
                          controller: weightController,
                          text: (getProfileInfo['data']['weight'] ?? '몸무게').toString(),
                          icon: Icons.star,
                          sufix: 'kg',
                        ),
                        SizedBox(height: 10),
                        CustomTextFiled(
                          controller: birthdayController,
                          text: (getProfileInfo['data']['brthdy'] ?? '생일').toString(),
                          icon: Icons.star,
                          sufix: '',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),

                  // Target 글자
                  Row(
                    children: [
                      SizedBox(width: 40),
                      Text(
                        'Target,',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Target 입력
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        CustomTextFiled(
                          controller: targetStepController,
                          text: (getProfileInfo['data']['stepTarget'] ?? '걸음수').toString(),
                          icon: Icons.print,
                          sufix: 'Steps',
                        ),
                        SizedBox(height: 10),
                        CustomTextFiled(
                          controller: targetWaterController,
                          text: (getProfileInfo['data']['waterTarget'] ?? '물').toString(),
                          icon: Icons.water_drop,
                          sufix: 'ml',
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await apiPutProfile();
                        await apiGetProfile();
                        await apiGetWater();
                        await apiGetStep();
                        print(getProfileInfo);
                        Navigator.pushNamed(context, '/home');
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
                      'Complete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
