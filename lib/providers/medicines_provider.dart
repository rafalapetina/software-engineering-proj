import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicinesProvider with ChangeNotifier {
  Map<String, String> _info = {
    'usuarioId': '',
    'tipo': '',
    'local': '',
    'date': '',
  };
  List<Widget> _type = [];

  Map<String, String> get items {
    return _info;
  }

  List<Widget> get doctors {
    return _type;
  }

  String getValue(key) {
    return _info[key];
  }

  void changeForm(key, value) {
    _info[key] = value;
    notifyListeners();
  }

  List<Widget> changeType(List<dynamic> docs) {
    _type.clear();
    docs.forEach((element) {
      _type.add(Text(element));
    });
    return _type;
  }

  createExam() async {
    var exames = await Firestore.instance.collection('exames').add(_info);
    return exames;
  }

  checkExams() async {
    var exames = await Firestore.instance.collection('exames').getDocuments();
    List<Widget> tipo = [];
    exames.documents.forEach((element) {
      var esp = element.data["tipo"];
      if (tipo.indexOf(Text(esp)) == -1)
        tipo.add(Text(esp));
    });
    return tipo;
  }
}
