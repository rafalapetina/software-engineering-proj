import 'package:flutter/material.dart';

class AppointmentForm with ChangeNotifier {
  Map<String, String> _form = {
    'usuarioId': '',
    'medicoId': 'Or5umBlNqlrwhpmrDIJZ',
    'Especialidade': '',
    'Medico': '',
    'Atendimento': '',
    'Local': '',
    'Horario': '',
    'link': 'https://meet.google.com/',
    'anamnese': ''
  };
  List<Widget> _doctors = [];

  Map<String, String> get items {
    return _form;
  }

  List<Widget> get doctors {
    return _doctors;
  }

  String getValue(key) {
    return _form[key];
  }

  void changeForm(key, value) {
    _form[key] = value;
    notifyListeners();
  }

  List<Widget> changeDoctors(List<dynamic> docs) {
    _doctors.clear();
    docs.forEach((element) {
      _doctors.add(Text(element));
    });
    return _doctors;
  }

}