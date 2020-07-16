import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dream_home/mainscreen.dart';
import 'package:dream_home/registerscreen.dart';
import 'package:dream_home/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dream_home/dialog_helper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  bool _passwordVisible;
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  String urlLogin = "http://yitengsze.com/cteng/php/login_user.php";
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  String _email = "";

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
    print("Hello i'm in INITSTATE");
    this.loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await DialogHelper.exit(context);
      },
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              upperHalf(context),
              lowerHalf(context),
              pageTitle(),
            ],
          )),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/images/login.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      height: 340,
      margin: EdgeInsets.only(top: screenHeight / 3),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: _emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus0);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),

                  //holding and releasing the longTap to see the password
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: !_passwordVisible,
                    controller: _passEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    focusNode: focus0,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus1);
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      icon: Icon(Icons.lock),
                      //hasFloatingPlaceholder: true,
                      suffixIcon: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            _passwordVisible = true;
                          });
                        },
                        onLongPressUp: () {
                          setState(() {
                            _passwordVisible = false;
                          });
                        },
                        child: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    // obscureText: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Checkbox(
                        checkColor: Colors.blue[400], // color of tick Mark
                        activeColor: Colors.blue[400],
                        value: rememberMe,
                        onChanged: (bool value) {
                          _onRememberMeChanged(value);
                        },
                      ),
                      Text('Remember Me ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: 100,
                        height: 50,
                        child: Text('Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        color: Colors.blue[400],
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: this._userLogin,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Not yet a member? ",
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              GestureDetector(
                onTap: _registerUser,
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Forgot your password ",
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              GestureDetector(
                onTap: _forgotPassword,
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> _registerUser() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text('Are you sure?',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            content: new Text('Do you want to register new account?',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RegisterScreen()));
                },
                child: Text("Yes",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(MdiIcons.homeOutline, size: 40, color: Colors.black),
          Text(
            "DREAM HOME",
            style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }

  void _userLogin() async {
    try {
      Toast.show("Login in progress", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      String _email = _emailEditingController.text;
      String _password = _passEditingController.text;
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.body);
        var string = res.body;
        List userdata = string.split(",");
        if (userdata[0] == "success") {
          User _user = new User(
              name: userdata[1],
              email: _email,
              password: _password,
              phone: userdata[3],
              credit: userdata[4],
              datereg: userdata[5],
              quantity: userdata[6]);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(
                        user: _user,
                      )));
        } else {
          Toast.show("Login failed.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
      });
    } on Exception catch (_) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text("Forgot Password?",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          content: new Container(
            height: 120,
            child: Column(
              children: <Widget>[
                Text("Enter your recovery email to reset password:",
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: _emailEditingController,
                  validator: validateEmail,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue[400],
                      ),
                      labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes",
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(false);
                _onResetPassword();
              },
            ),
            new FlatButton(
              child: new Text("No",
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String validateEmail(String value) {
    if (value.length == 0) {
      return "Email is Required";
    } else {
      return null;
    }
  }

  void _onResetPassword() {
    String urlPass = "http://yitengsze.com/cteng/php/forgetpswd.php";
    print("Done reset password. Check your email.");
    _email = _emailEditingController.text;
    if (_isEmailValid(_email)) {
      Toast.show("Sending link to your email. Check your email.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      http.post(urlPass, body: {
        "email": _email,
      }).then((res) {
        Toast.show("Success in sending email. Pls check.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }).catchError((err) {
        print(err);
      });
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        print(rememberMe);
        if (rememberMe) {
          savepref(true);
        } else {
          savepref(false);
        }
      });

  void loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
        rememberMe = true;
      });
    }
  }

  void savepref(bool value) async {
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Toast.show("Preferences have been saved", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        rememberMe = false;
      });
      Toast.show("Preferences have removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
