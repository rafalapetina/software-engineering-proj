import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String id, name, sex, alergies;
  int cpf, age, phone, weight, height, insuranceNum;
  static bool isDoc;

  User();

  getUserInfo() async {
    var user = await FirebaseAuth.instance.currentUser();
    this.id = user.uid;
    var userInfo;
    if (await isDoctor())
      userInfo = await Firestore.instance.collection('/medicos').document(user.uid).get();
    else 
      userInfo = await Firestore.instance.collection('/usuarios').document(user.uid).get();
    print(userInfo);
    if (userInfo.data == null) return false;
    this.name = userInfo['nome'];
    this.sex = userInfo['sexo'];
    this.alergies = userInfo['alergias'];
    this.cpf = userInfo['cpf'];
    this.age = userInfo['idade'];
    this.phone = userInfo['celular'];
    this.height = userInfo['altura'];
    this.weight = userInfo['peso'];
    this.insuranceNum = userInfo['plano'];
    return true;
  }

  isDoctor() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userInfo = await Firestore.instance.collection('/medicos').document(user.uid).get();
    User.isDoc = userInfo.data != null;
    return userInfo.data != null;
  }
}

