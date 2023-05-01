import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/usermodel.dart';
import 'package:frontend/src/views/homeview.dart';
import 'package:frontend/src/views/registrationview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String errorOutput = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLogin = true;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: email, password: password);
      loginUser();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorOutput = e.message ?? 'Unknown Error.';
      });
    }
  }

  void loginUser() {
    UserModel().setUsername(email.split('@')[0].substring(0, 12));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          resizeToAvoidBottomInset: true,
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 150,
                          width: 150,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                            image: AssetImage('assets/shouttplogo.png'),
                          ))),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        ),
                        Form(
                          key: _formKey,
                          onChanged: () {
                            Form.of(primaryFocus!.context!)!.validate();
                          },
                          child: Wrap(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person_pin,
                                      color: Theme.of(context).primaryColor),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                onSaved: (String? email) {
                                  // Sent when a form is saved
                                  if (email != null) {
                                    this.email = email;
                                  }
                                },
                                validator: (String? email) {
                                  // Validation checks go here
                                  // I.E we don't want @'s or weird characters in names
                                  if (email != null && email.length > 1) {
                                    _formKey.currentState!.save();
                                  }
                                },
                              ),
                              TextFormField(
                                // TODO: Blur / star out password text
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock,
                                      color: Theme.of(context).primaryColor),
                                  iconColor: Theme.of(context).primaryColor,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                obscureText: true,
                                onSaved: (String? password) {
                                  // Sent when a form is saved
                                  if (password != null) {
                                    this.password = password;
                                  }
                                },
                                validator: (String? password) {
                                  // Validation checks go here
                                  if (password != null && password.length > 1) {
                                    _formKey.currentState!.save();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            signInWithEmailAndPassword();
                          },
                          child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        ),
                        register(),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        ),
                        _errorText(errorOutput),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  Widget register() {
    const TextStyle defaultStyle =
        TextStyle(color: Colors.grey, fontSize: 15.0);
    const TextStyle linkStyle = TextStyle(color: Colors.blue);

    return RichText(
        text: TextSpan(style: defaultStyle, children: <TextSpan>[
      const TextSpan(text: "New to Shout? "),
      TextSpan(
          text: 'Register here!',
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationScreen()),
              );
            })
    ]));
  }

  Widget _errorText(String error) {
    if (errorOutput != '') {
      return Text(
        error,
        style: const TextStyle(color: Colors.red),
      );
    }
    return Container();
  }
}
