import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:health_app/screens/services_screen.dart';
import 'package:health_app/widgets/dropdown_widget.dart';

class RegisterInfo extends StatelessWidget {
  static const routeName = '/registerInfo';

  @override
  Widget build(BuildContext context) {
    final isFirstAccess = !Navigator.of(context).canPop();
    final crm = ModalRoute.of(context).settings.arguments as String;
    var isDoctor;

    if (isFirstAccess)
      isDoctor = crm != null;
    else
      isDoctor = User.isDoc;

    final _formKey = GlobalKey<FormState>();
    Map<String, dynamic> form = {
      'nome': '',
      'sexo': '',
      'alergias': '',
      'cpf': 0,
      'idade': 0,
      'celular': 0,
      'peso': 0,
      'altura': 0
    };
    if (isDoctor)
      form = {
        'nome': '',
        'CRM': crm,
        'especialidade': '',
        'celular': 0,
        'cpf': 0,
        'consultasAtendidas': 0
      };

    _trySubmit() async {
      var isValid = _formKey.currentState.validate();
      if (isValid) {
        _formKey.currentState.save();
        var user = await FirebaseAuth.instance.currentUser();
        if (isDoctor) {
          Firestore.instance
              .collection('medicos')
              .document(user.uid)
              .setData(form);
        } else {
          Firestore.instance
              .collection('usuarios')
              .document(user.uid)
              .setData(form);
        }

        if (!isFirstAccess)
          Navigator.pop(context);
        else
          Navigator.of(context).pushReplacementNamed(ServicesScreen.routeName);
      }
    }

    getUserInfo() async {
      var user = await FirebaseAuth.instance.currentUser();
      var info;
      if (!User.isDoc) {
        info = await Firestore.instance
            .collection('usuarios')
            .document(user.uid)
            .get();
      } else {
        info = await Firestore.instance
            .collection('medicos')
            .document(user.uid)
            .get();
      }
      return info;
    }

    return Scaffold(
      appBar: !isFirstAccess
          ? AppBar(
              title: Text('Informações pessoais'),
            )
          : null,
      backgroundColor: Color.fromRGBO(255, 227, 227, 1),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getUserInfo(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: isFirstAccess ? 50 : 10),
                            if (isFirstAccess)
                              Text(
                                'Para começar a usar o aplicativo, preencha alguma informações pessoais',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            SizedBox(height: 40),
                            TextFormField(
                              key: ValueKey('name'),
                              initialValue:
                                  isFirstAccess ? '' : snapshot.data['nome'],
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: 'Nome',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Nome inválido!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                form['nome'] = value;
                              },
                            ),
                            if (isDoctor)
                              SizedBox(
                                height: 10,
                              ),
                            if (isDoctor)
                              TextFormField(
                                key: ValueKey('especialidade'),
                                initialValue: isFirstAccess
                                    ? ''
                                    : snapshot.data['especialidade'],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Especialidade',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Especialidade inválida!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  form['especialidade'] = value;
                                },
                              ),
                            if (isDoctor)
                              SizedBox(
                                height: 10,
                              ),
                            if (isDoctor)
                              TextFormField(
                                key: ValueKey('crm'),
                                initialValue:
                                    isFirstAccess ? crm : snapshot.data['crm'],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'CRM',
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      int.tryParse(value) == null) {
                                    return 'CRM inválido!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  form['CRM'] = value;
                                },
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              key: ValueKey('cpf'),
                              initialValue: isFirstAccess
                                  ? ''
                                  : snapshot.data['cpf'].toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: 'CPF',
                              ),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length != 11 ||
                                    int.tryParse(value) == null) {
                                  return 'CPF inválido';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                form['cpf'] = int.parse(value);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (!isDoctor)
                              TextFormField(
                                key: ValueKey('age'),
                                initialValue: isFirstAccess
                                    ? ''
                                    : snapshot.data['idade'].toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Idade',
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length > 2 ||
                                      int.tryParse(value) == null) {
                                    return 'Idade inválida';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  form['idade'] = int.parse(value);
                                },
                              ),
                            if (!isDoctor)
                              SizedBox(
                                height: 10,
                              ),
                            if (!isDoctor)
                              CustomDropdown(form, snapshot, isFirstAccess),
                            if (!isDoctor) SizedBox(height: 10),
                            if (!isDoctor)
                              TextFormField(
                                key: ValueKey('insuranceNum'),
                                initialValue: isFirstAccess
                                    ? ''
                                    : snapshot.data['plano'].toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Número do plano de saúde',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Número do plano inválido';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  form['plano'] = int.parse(value);
                                },
                              ),
                            if (!isDoctor) SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('celNumber'),
                              initialValue: isFirstAccess
                                  ? ''
                                  : snapshot.data['celular'].toString(),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: 'Celular',
                              ),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 10 ||
                                    int.tryParse(value) == null) {
                                  return 'Número de celular inválido';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                form['celular'] = int.parse(value);
                              },
                            ),
                            SizedBox(height: 10),
                            if (!isDoctor)
                              TextFormField(
                                key: ValueKey('weight'),
                                initialValue: isFirstAccess
                                    ? ''
                                    : snapshot.data['peso'].toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Peso (Kg)',
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length > 3 ||
                                      int.tryParse(value) == null) {
                                    return 'Peso inválido';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  form['peso'] = int.parse(value);
                                },
                              ),
                            SizedBox(height: 10),
                            if (!isDoctor)
                              TextFormField(
                                key: ValueKey('height'),
                                initialValue: isFirstAccess
                                    ? ''
                                    : snapshot.data['altura'].toString(),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Altura (cm)',
                                ),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      int.tryParse(value) == null) {
                                    return 'Altura inválida';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  form['altura'] = int.parse(value);
                                },
                              ),
                            SizedBox(height: 10),
                            if (!isDoctor)
                              TextFormField(
                                key: ValueKey('alergies'),
                                initialValue: isFirstAccess
                                    ? ''
                                    : snapshot.data['alergias'],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Alergias',
                                ),
                                onSaved: (value) {
                                  form['alergias'] = value;
                                },
                              ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _trySubmit,
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 40),
                              ),
                              child: Text(
                                'Confirmar',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
