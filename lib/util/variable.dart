import 'package:flutter/cupertino.dart';


// 유저 정보
Map<String, dynamic> getProfileInfo = {};
Map<String, dynamic> getWaterInfo = {};
Map<String, dynamic> getStepInfo = {};
Map<String, dynamic> putProfileInfo = {};


// Profile & Target
final nickNameController = TextEditingController();
final heightController = TextEditingController();
final weightController = TextEditingController();
final birthdayController = TextEditingController();
final targetStepController = TextEditingController();
final targetWaterController = TextEditingController();
String tapS = '';