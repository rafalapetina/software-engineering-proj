import 'package:flutter/material.dart';

class AppointmentForm with ChangeNotifier {
  Map<String, dynamic> _form = {
    'usuarioId': '',
    'medicoId': 'Or5umBlNqlrwhpmrDIJZ',
    'Especialidade': '',
    'Medico': '',
    'Atendimento': '',
    'Local': '',
    'Horario': '',
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
    if (key)
    _form[key] = value;
    notifyListeners();
  }

  List<Widget> changeDoctors(List<String> docs) {
    _doctors.clear();
    docs.forEach((element) {
      _doctors.add(Text(element));
    });
    return _doctors;
  }

}