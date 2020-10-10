import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../constants/colorConstants.dart';
import 'package:provider/provider.dart';

enum AuthMode {
  Login,
  Signup,
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  var _authmode = AuthMode.Login;
  var _isLoading = false;
  final passwordnode = FocusNode();
  final confirmnode = FocusNode();
  var email = '';
  var password = '';
  Future<void> _submit() async {
    UserCredential authresult;
    _formkey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authmode == AuthMode.Login) {
        authresult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print(authresult);
        //Provider.of(context, listen: false)._authentication()
      } else {
        authresult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      }
    } on PlatformException catch (err) {
      var message = "An Error occured, Please Check your Credentials";
      if (err.message != null) message = err.message;
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchMode() {
    if (_authmode == AuthMode.Signup) {
      setState(() {
        _authmode = AuthMode.Login;
      });
    } else
      setState(() {
        _authmode = AuthMode.Signup;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteAlternateColor,
      appBar: AppBar(
        title: Text(
          'Authentication',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Card(
          color: kwhiteAlternateColor,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  _authmode == AuthMode.Login ? Text('Login') : Text('Signup'),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) => email = (val.trim()),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Invalid Email';
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    onSaved: (val) => password = val,
                    focusNode: passwordnode,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (_authmode == AuthMode.Signup)
                    TextFormField(
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Confirm Password',
                        icon: Icon(Icons.security_sharp),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text)
                          return 'Password Not Match';
                      },
                      focusNode: confirmnode,
                      obscureText: true,
                    ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      onPressed: _submit,
                      child: _authmode == AuthMode.Signup
                          ? Text('Signup')
                          : Text('Login'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  FlatButton(
                      onPressed: _switchMode,
                      child: _authmode == AuthMode.Signup
                          ? Text('Already have Account')
                          : Text('Don\'t have Account')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
