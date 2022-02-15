import 'package:flutter/material.dart';
import 'package:health_app/helpers/dismiss_keyboard.dart';
import 'package:health_app/screens/register_info_screen.dart';

class PreRegister extends StatefulWidget {
  static const routeName = '/preRegister';

  @override
  _PreRegisterState createState() => _PreRegisterState();
}

class _PreRegisterState extends State<PreRegister> {
  final isSelected = [true, false];
  var crm = '';

  void _trySubmit() {
    if (isSelected[0]) {
      Navigator.of(context).pushReplacementNamed(RegisterInfo.routeName);
      return;
    }
    if (crm != '') {
      Navigator.of(context)
          .pushReplacementNamed(RegisterInfo.routeName, arguments: crm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 227, 227, 1),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/undraw_medicine_b1ol.png'),
                    SizedBox(height: 60),
                    Text(
                      'Você é um paciente ou médico?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    ToggleButtons(
                      children: [
                        Text(
                          'Paciente',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Médico',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      isSelected: isSelected,
                      borderRadius: BorderRadius.circular(15),
                      borderWidth: 1,
                      borderColor: Colors.black,
                      selectedBorderColor: Colors.black,
                      constraints: BoxConstraints.tight(Size(165, 40)),
                      fillColor: Colors.red,
                      color: Colors.red,
                      selectedColor: Colors.white,
                      onPressed: (index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    if (isSelected[1])
                      TextFormField(
                        key: ValueKey('CRM'),
                        keyboardType: TextInputType.phone,
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
                              value.length != 9 ||
                              int.tryParse(value) == null) {
                            return 'CRM inválido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          crm = value;
                        },
                        // onSaved: (value) {
                        //   crm = value;
                        // },
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _trySubmit,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 40),
                      ),
                      child: Text(
                        'Próximo',
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
