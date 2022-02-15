import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamProvider with ChangeNotifier {
  Map<String, dynamic> _info = {
    'medicoId': '',
    'nome': '',
    'especialidade': '',
    'CRM': 0,
    'CPF': 0,
    'celular': 0,
  };
  List<Widget> _doctors = [];

  Map<String, String> get items {
    return _info;
  }

  List<Widget> get doctors {
    return _doctors;
  }

  String getValue(key) {
    return _info[key];
  }

  void changeInfo(key, value) {
    _info[key] = value;
    notifyListeners();
  }

  List<Widget> changeDoctors(List<dynamic> docs) {
    _doctors.clear();
    docs.forEach((element) {
      _doctors.add(Text(element));
    });
    return _doctors;
  }

  createDoctor() async {
    var exames = await Firestore.instance.collection('medicos').add(_info);
  }

  checkDoctors() async {
    var exames = await Firestore.instance.collection('medicos').getDocuments();
    List<Widget> id = [];
    exames.documents.forEach((element) {
      var esp = element.data["medicoId"];
      if (id.indexOf(Text(esp)) == -1)
        id.add(Text(esp));
    });
    return id;
  }
}
