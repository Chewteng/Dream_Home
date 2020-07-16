import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dream_home/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double screenHeight, screenWidth;
  bool _isChecked = false;
  bool _validate = false;
  String urlRegister = "http://yitengsze.com/cteng/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  String name, email, password, phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  String pathAsset = 'assets/images/profile.png';
  bool passwordVisible = false;
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
              children: <Widget>[
                Form(
                    key: _formKey,
                    autovalidate: _validate,
                    child: Stack(
                      children: <Widget>[
                        upperHalf(context),
                        lowerHalf(context),
                      ],
                    )),
              ],
            )));
  }

  Widget upperHalf(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 38),
          GestureDetector(
              onTap: _choose,
              child: Center(
                child: Container(
                  height: screenHeight / 4.8,
                  width: screenWidth / 3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: _image == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image),
                        fit: BoxFit.cover,
                      )),
                ),
              )),
          SizedBox(height: 10),
          Text('Click on image above to take profile picture',
              style: TextStyle(
                color: Colors.white,
              )),
        ]);
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
        height: 550,
        margin: EdgeInsets.only(top: screenHeight / 3.4),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Register",
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
                        controller: _nameEditingController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus0);
                        },
                        decoration: new InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            hintText: 'e.g Julia',
                            icon: Icon(Icons.person)),
                        maxLength: 32,
                        validator: validateName,
                        onSaved: (String val) {
                          name = val;
                        },
                      ),
                      TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          controller: _emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: focus0,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus1);
                          },
                          decoration: new InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            hintText: 'e.g abc@gmail.com',
                            icon: Icon(Icons.email),
                          ),
                          maxLength: 50,
                          validator: validateEmail,
                          onSaved: (String val) {
                            email = val;
                          }),
                      TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          controller: _phoneditingController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          focusNode: focus1,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus2);
                          },
                          decoration: new InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            hintText: 'Enter your complete phoneNo.',
                            icon: Icon(Icons.phone),
                          ),
                          maxLength: 10,
                          validator: validatePhone,
                          onSaved: (String val) {
                            phone = val;
                          }),
                      TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          controller: _passEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          focusNode: focus2,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focus3);
                          },
                          maxLength: 32,
                          obscureText:
                              passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            hintText: 'Enter your password',
                            icon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: validatePassword,
                          onSaved: (String val) {
                            password = val;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.blue[400], // color of tick Mark
                            activeColor: Colors.blue[400],
                            value: _isChecked,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          GestureDetector(
                            onTap: _showEULA,
                            child: Text('Agree to Terms',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            minWidth: 115,
                            height: 50,
                            child: Text('Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )),
                            color: Colors.blue[400],
                            textColor: Colors.white,
                            elevation: 10,
                            onPressed: _onRegister,
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
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already a member? ",
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  GestureDetector(
                    onTap: _loginScreen,
                    child: Text(
                      "Login",
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
        ));
  }

  String validateName(String value) {
    //String patttern = r'(^[a-zA-Z ]*$)';
    // RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    }
    return null;
  }

  String validateEmail(String value) {
    // String pattern =
    ///     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    }
    return null;
  }

  String validatePhone(String value) {
    //String patttern = r'(^[0-9]*$)';
    //RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Phone Number is Required";
    } else if (value.length != 10) {
      return "Phone number must 10 digits";
    }
    return null;
  }

  String validatePassword(String value) {
    //RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Must be more than 5 charater';
    }
    return null;
  }

  Future<bool> _onBackPressed() {
    _image = null;
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text('Are you sure?',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            content: new Text('Do you want to exit register screen?',
                style: TextStyle(
                    fontSize: 16.0,
                    //fontWeight: FontWeight.bold,
                    color: Colors.white)),
            actions: <Widget>[
              Icon(
                MdiIcons.menuRight,
                size: 40,
                color: Colors.white70,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
                child: Text("Yes",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ],
          ),
        ) ??
        false;
  }

  void _choose() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Select the image source",
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() => _image = file);
      }
    }
  }

  void _onRegister() {
    name = _nameEditingController.text;
    email = _emailEditingController.text;
    phone = _phoneditingController.text;
    password = _passEditingController.text;

    if ((_isEmailValid(email)) &&
        (password.length > 5) &&
        (_image != null) &&
        (phone.length == 10) &&
        _isChecked) {
      // validation error
      Toast.show("Registration in progress", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      String base64Image = base64Encode(_image.readAsBytesSync());
      http.post(urlRegister, body: {
        "encoded_string": base64Image,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      }).then((res) {
        Toast.show(
            "Rgistration Success. Verify email first before login!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            print("Register Successfully.");
            print("Verify email first before login!");
        _image = null;
        // savepref(_email, _password);
        _nameEditingController.text = '';
        _phoneditingController.text = '';
        _emailEditingController.text = '';
        _passEditingController.text = '';
        //pr.dismiss();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
      }).catchError((err) {
        print(err);
      });
    } else {
      setState(() {
        _validate = true;
      });
      Toast.show("Check your registration information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  void _loginScreen() {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text('Are you sure?',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        content: new Text('Do you want to back to LoginScreen?',
            style: TextStyle(
                fontSize: 16.0,
                //fontWeight: FontWeight.bold,
                color: Colors.white)),
        actions: <Widget>[
          Icon(
            MdiIcons.menuRight,
            size: 40,
            color: Colors.white70,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
            },
            child: Text("Yes",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
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
    );
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text("TERMS AND CONDITIONS : ",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(color: Colors.white),
                            text:
                                "This End-User License Agreement is a legal agreement between you and DreamHome. This EULA agreement governs your acquisition and use of our dream home software (Software) directly from DreamHome or indirectly through a DreamHome authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the dream home software. It provides a license to use the dream home software and contains warranty information and liability disclaimers. If you register for a free trial of the dream home software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the dream home software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by DreamHome herewith regardless of whether other software is referred to or described herein. The terms also apply to any DreamHome updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for dream home. DreamHome shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of DreamHome. DreamHome reserves the right to grant licences to use the Software to third parties.")),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
