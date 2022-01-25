import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/screens/services_screen.dart';
import 'package:health_app/widgets/dropdown_widget.dart';

class RegisterInfo extends StatelessWidget {
  static const routeName = '/registerInfo';

  @override
  Widget build(BuildContext context) {
    final crm = ModalRoute.of(context).settings.arguments as String;

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

    _trySubmit() async{
      var isValid = _formKey.currentState.validate();
      print(form);
      // FocusScope.of(context).unfocus();
      if (isValid) {
        _formKey.currentState.save();
        print(form);
        var user = await FirebaseAuth.instance.currentUser();
        Firestore.instance.collection('usuarios').document(user.uid).setData(form);
        Navigator.of(context).pushReplacementNamed(ServicesScreen.routeName);
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 227, 227, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
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
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      key: ValueKey('cpf'),
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
                    TextFormField(
                      key: ValueKey('age'),
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
                    SizedBox(
                      height: 10,
                    ),
                    CustomDropdown(form),
                    SizedBox(height: 10),
                    TextFormField(
                      key: ValueKey('insuranceNum'),
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
                    SizedBox(height: 10),
                    TextFormField(
                      key: ValueKey('celNumber'),
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
                    TextFormField(
                      key: ValueKey('weight'),
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
                    TextFormField(
                      key: ValueKey('height'),
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
                        if (value.isEmpty || int.tryParse(value) == null) {
                          return 'Altura inválida';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        form['altura'] = int.parse(value);
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      key: ValueKey('alergies'),
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
                        'Enviar',
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
    );
  }
}
