import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(String email, String password, bool isLogin, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  bool isHidden = true;
  String _userEmail = '';
  String _password = '';

  void _trySubmit() {
    var isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _password, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _isLogin ? 'Log In' : 'Cadastre-se',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.all(20),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                height: _isLogin ? 300 : 380,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          key: ValueKey('email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              // setState(() {
                              //   validInputs = false;
                              // });
                              return 'Email inválido!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              key: ValueKey('password'),
                              decoration: InputDecoration(
                                labelText: 'Senha',
                              ),
                              obscureText: isHidden,
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  // setState(() {
                                  //   validInputs = false;
                                  // });
                                  return 'Senha é muito curta!';
                                }
                                _password = value;
                                return null;
                              },
                              onSaved: (value) {
                                _password = value;
                              },
                            ),
                            IconButton(
                              icon: isHidden
                                  ? Icon(CupertinoIcons.eye)
                                  : Icon(CupertinoIcons.eye_slash),
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                            ),
                          ],
                        ),
                        if (!_isLogin)
                          TextFormField(
                            key: ValueKey('confirmPassword'),
                            decoration: InputDecoration(
                              labelText: 'Confirme a senha',
                            ),
                            obscureText: isHidden,
                            validator: (value) {
                              if (value != _password) {
                                return 'Senhas não são iguais!';
                              }
                              return null;
                            },
                          ),
                        SizedBox(
                          height: 20,
                          width: deviceSize.width,
                        ),
                        ElevatedButton(
                          onPressed: _trySubmit,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 40),
                          ),
                          child: Text(
                            _isLogin ? 'Log in' : 'Cadastrar',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          width: deviceSize.width,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin ? 'Criar conta' : 'Já tenho cadastro',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
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
      ],
    );
  }
}
