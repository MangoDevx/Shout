import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:frontend/auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/views/loginview.dart';
import 'package:frontend/src/views/settingsview.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  String phoneNumber = '';
  String errorOutput = '';
  bool invalidCreds = false;
  bool passwordsMatch = false;
  bool loggedIn = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLogin = false;

  @override
  initState() {
    super.initState();
    if (loggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth()
          .createUserWithEmailAndPassword(email: email, password: password);
      //push to home screen
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorOutput = e.message ?? 'Error';
        invalidCreds = true;
      });
    }
    setState(() {
      loggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: topAppBar(),
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
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
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
                                  color: Theme.of(context).primaryColorDark),
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
                          _spacer(),
                          TextFormField(
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
                                  color: Theme.of(context).primaryColorDark),
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
                          _spacer(),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock,
                                  color: Theme.of(context).primaryColor),
                              iconColor: Theme.of(context).primaryColor,
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            obscureText: true,
                            validator: (String? confirmedPassword) {
                              // Validation checks go here
                              if (confirmedPassword != null &&
                                  password.length > 1) {
                                if (confirmedPassword == password) {
                                  passwordsMatch = true;
                                } else {
                                  passwordsMatch = false;
                                }
                              }
                            },
                          ),
                          _spacer(),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone,
                                  color: Theme.of(context).primaryColor),
                              iconColor: Theme.of(context).primaryColor,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            onSaved: (String? phoneNumber) {
                              // Sent when a form is saved
                              if (phoneNumber != null) {
                                phoneNumber = phoneNumber.replaceAll(' ', '');
                                phoneNumber = phoneNumber.replaceAll('-', '');
                                this.phoneNumber = phoneNumber;
                              } else {
                                const Text(
                                  'Please fill out all of the above forms to continue.',
                                  style: TextStyle(color: Colors.red),
                                );
                              }
                            },
                            validator: (String? phoneNumber) {
                              // Validation checks go here
                              if (phoneNumber != null) {
                                phoneNumber = phoneNumber.replaceAll(' ', '');
                                phoneNumber = phoneNumber.replaceAll('-', '');
                                if (phoneNumber.length <= 11 &&
                                    phoneNumber.length >= 10) {
                                  _formKey.currentState!.save();
                                }
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
                        createUserWithEmailAndPassword();
                      },
                      child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    ),
                    login(),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    ),
                    _errorText(errorOutput),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  PreferredSizeWidget topAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      centerTitle: true,
      title: Image.asset('assets/shoutnotext.png',
          fit: BoxFit.contain, height: 35),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _spacer() {
    return const SizedBox(
      height: 70,
    );
  }

  Widget _errorText(String value) {
    if (invalidCreds == true) {
      return Text(
        value,
        style: const TextStyle(color: Colors.red),
      );
    }
    return Container();
  }

  Widget login() {
    const TextStyle defaultStyle =
        TextStyle(color: Colors.grey, fontSize: 15.0);
    const TextStyle linkStyle = TextStyle(color: Colors.blue);

    return RichText(
        text: TextSpan(style: defaultStyle, children: <TextSpan>[
      const TextSpan(text: "Have an account? "),
      TextSpan(
          text: 'Login.',
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            })
    ]));
  }
}
