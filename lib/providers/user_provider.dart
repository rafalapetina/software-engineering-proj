import 'package:flutter/material.dart';

class User with ChangeNotifier{
  final String id, name, sex, alergies;
  final int cpf, age, cellNum, weight, height, insuranceNum;

  User({@required this.id,
  @required this.name,
  @required this.cpf,
  @required this.age,
  @required this.sex,
  @required this.cellNum,
  @required this.weight,
  @required this.height,
  @required this.insuranceNum,
  @required this.alergies,
  });

  registerUserInfo() async {

  }
}

