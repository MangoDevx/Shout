import 'package:flutter/material.dart';
import 'package:frontend/src/views/homeview.dart';
import 'package:frontend/src/controllers/loginregistercontroller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String username = '';
  String password = '';
  String phoneNumber = '';
  String errorOutput = '';
  bool invalidCreds = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _sendCredentials() async {
    var response = await sendRegistrationCredentials(username, password, phoneNumber);
    if (response.statusCode == 200) {
      // Clear the data from memory
      username = '';
      password = '';
      phoneNumber = '';

      loginUser();
    } else {
      setState(() {
        invalidCreds = true;
        errorOutput = response.responseBody;
      });
    }
  }

  void loginUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                          hintText: 'Username',
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        onSaved: (String? username) {
                          // Sent when a form is saved
                          if (username != null) {
                            this.username = username;
                          }
                        },
                        validator: (String? username) {
                          // Validation checks go here
                          // I.E we don't want @'s or weird characters in names
                          if (username != null && username.length > 1) {
                            _formKey.currentState!.save();
                          }
                        },
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock,
                              color: Theme.of(context).primaryColor),
                          iconColor: Theme.of(context).primaryColor,
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
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
                      TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock,
                              color: Theme.of(context).primaryColor),
                          iconColor: Theme.of(context).primaryColor,
                          hintText: 'Confirm Password',
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        onSaved: (String? password) {
                          // Sent when a form is saved
                          if (password != null && password == this.password) {
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
                      TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone,
                              color: Theme.of(context).primaryColor),
                          iconColor: Theme.of(context).primaryColor,
                          hintText: 'Phone Number',
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
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
                          if (phoneNumber != null && phoneNumber.length > 1) {
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
                    _sendCredentials();
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                ),
                _errorText(errorOutput),
              ],
            ),
          ),
        ));
  }

  Widget _errorText(String value) {
    if (invalidCreds == true) {
      return const Text(
        value,
        style: TextStyle(color: Colors.red),
      );
    }
    return Container();
  }
}
