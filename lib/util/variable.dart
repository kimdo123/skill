import 'package:flutter/cupertino.dart';


// 유저 정보
Map<String, dynamic> getProfileInfor = {};
Map<String, dynamic> getWaterInfor = {};
Map<String, dynamic> getStepInfor = {};
Map<String, dynamic> putProfileInfor = {};


// Profile & Target
final nickNameController = TextEditingController();
final heightController = TextEditingController();
final weightController = TextEditingController();
final birthdayController = TextEditingController();
final targetStepController = TextEditingController();
final targetWaterController = TextEditingController();
String tapS = '';