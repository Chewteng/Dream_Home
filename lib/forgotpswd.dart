import 'package:dream_home/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';

class ForgotPassword extends StatefulWidget {
  final String email;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
  const ForgotPassword({Key key, this.email}) : super(key: key);
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailcontroller = TextEditingController();
  String _email = "";
  String urlPass = "http://yitengsze.com/cteng/php/forgetpswd.php";
  bool _validate = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        backgroundColor: Colors.orange[100],
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Reset Password'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text("Enter your email address to reset password"),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  autovalidate: _validate,
                  controller: _emailcontroller,
                  validator: validateEmail,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    icon: Icon(Icons.person),
                  )),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 200,
                height: 50,
                child: Text('Reset Password'),
                color: Colors.orange,
                textColor: Colors.black,
                elevation: 15,
                onPressed: _onResetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    if (value.length == 0) {
      return "Email is Required";
    } else {
      return null;
    }
  }

  Future<bool> _onBackPressAppBar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
    return Future.value(false);
  }

  void _onResetPassword() {
    print("Reset Password");
    _email = _emailcontroller.text;
    if (_isEmailValid(_email)) {
      Toast.show("Sending link to your email. Check your email.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      http.post(urlPass, body: {
        "email": _email,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //pr.dismiss();
        if (res.body ==
            "The temporary password had been sent, please check your email.") {
          print('Checkkkkk...');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
        }
      }).catchError((err) {
        print(err);
      });
    } else {
      setState(() {
        _validate = true;
      });
      Toast.show("Check your email format and must enter your email", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
