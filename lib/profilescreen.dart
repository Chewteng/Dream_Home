import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dream_home/wallethistory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'user.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:recase/recase.dart';
import 'loginscreen.dart';
import 'package:sms/sms.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String server = "https://yitengsze.com/cteng";
  double screenHeight, screenWidth;
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  var parsedDate;

  @override
  void initState() {
    super.initState();
    print("Profile Screen");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    parsedDate = DateTime.parse(widget.user.datereg);

    return Scaffold(
      appBar: AppBar(title: Text('Account Information'), actions: <Widget>[
        IconButton(
          icon: Icon(MdiIcons.messageReplyText),
          onPressed: _callHelp,
        ),
      ]),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    height: 175.0,
                    color: Colors.black,
                    child: Center(
                        child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(server +
                                "/profileimages/${widget.user.email}.jpg?"),
                            fit: BoxFit.fitWidth),
                      ),
                      child: ClipRRect(
                        // make sure we apply clip it properly
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                    )),
                  )),
              Flexible(
                //width: screenWidth / 1.1,
                // color: Colors.white,
                child: Card(
                  elevation: 6,
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 55, 0, 50),
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(children: <Widget>[
                                SizedBox(height: 5),
                                Text("Member since ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 2),
                                Text(f.format(parsedDate),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ])
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.fromLTRB(141, 5, 137, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0)),
                              color: Colors.blue[400],
                            ),
                            child: Text("Profile Details",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                          SizedBox(height: 20),
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(4),
                              1: FlexColumnWidth(10),
                            },
                            children: [
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                      child: Icon(Icons.email,
                                          color: Colors.blue[400])),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 55,
                                    child: Text(widget.user.email,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: changeName,
                                            child: Icon(Icons.people,
                                                color: Colors.blue[400]))
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 55,
                                    child: Text(widget.user.name,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                      child: Column(children: <Widget>[
                                    GestureDetector(
                                        onTap: changePhone,
                                        child: Icon(Icons.phone,
                                            color: Colors.blue[400]))
                                  ])),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 55,
                                    child: Text("+60 " + widget.user.phone,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                      child: Column(children: <Widget>[
                                    GestureDetector(
                                        onTap: changePassword,
                                        child: Icon(MdiIcons.lock,
                                            color: Colors.blue[400]))
                                  ])),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 55,
                                    child: Text("*********",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  child: Container(
                                      child: Column(children: <Widget>[
                                    GestureDetector(
                                        onTap: walletTopUp,
                                        child: Icon(MdiIcons.wallet,
                                            color: Colors.blue[400]))
                                  ])),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 55,
                                    child: Text("RM " + widget.user.credit,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ]),
                      )),
                ),
              )
            ],
          ),
          // Profile image
          Positioned(
            top: 70.0,
            //left: 15, // (background container size) - (circle height / 2)
            child: Container(
              height: 155.0,
              width: 155.0,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                          server + "/profileimages/${widget.user.email}.jpg?"),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }

  _callHelp() {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@dreamhome.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Need some help from our consultant via SMS? ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);

                SmsSender sender = new SmsSender();
                String address = "+60" + widget.user.phone;
                sender.sendSms(new SmsMessage(
                  address,
                  "Are you there? I need some help regarding to DreamHome!",
                ));
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue[400],
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.blue[400],
                ),
              )),
        ],
      ),
    );
  }

  void changeName() {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@dreamhome.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your name?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue[400],
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    ),
                    onPressed: () =>
                        _changeName(nameController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.blue[400],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changeName(String name) {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (name == "" || name == null) {
      Toast.show("Please enter your new name", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    ReCase rc = new ReCase(name);
    print(rc.titleCase.toString());
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "name": rc.titleCase.toString(),
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.name = rc.titleCase;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePassword() {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController oldpassController = TextEditingController();
    TextEditingController newpassController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your password?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: oldpassController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.blue[400],
                        ),
                      )),
                  TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      controller: newpassController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.blue[400],
                        ),
                      )),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    ),
                    onPressed: () => updatePassword(
                        oldpassController.text, newpassController.text)),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.blue[400],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  updatePassword(String pass1, String pass2) {
    if (pass1 == "" || pass2 == "") {
      Toast.show("Please enter your password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "oldpassword": pass1,
      "newpassword": pass2,
    }).then((res) {
      if (res.body == "success") {
        print('in success');
        setState(() {
          widget.user.password = pass2;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _gotologinPage();
        //Navigator.of(context).pop();
        //return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void _gotologinPage() {
    // flutter defined function
    print(widget.user.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Go to login page?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue[400],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.blue[400],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changePhone() {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController phoneController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your phone number?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'New Phone Number',
                    icon: Icon(
                      Icons.phone,
                      color: Colors.blue[400],
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    ),
                    onPressed: () =>
                        _changePhone(phoneController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.blue[400],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changePhone(String phone) {
    if (phone == "" || phone == null || phone.length < 9) {
      Toast.show("Please enter your new phone number", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        print('in success');
        setState(() {
          widget.user.phone = phone;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
        return;
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _takePicture() async {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@dreamhome.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    File _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 300);
    //print(_image.lengthSync());
    if (_image == null) {
      Toast.show("No image is pictured.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      String base64Image = base64Encode(_image.readAsBytesSync());
      print(base64Image);
      http.post(server + "/php/upload_profile.php", body: {
        "encoded_string": base64Image,
        "email": widget.user.email,
      }).then((res) {
        print(res.body);
        if (res.body == "success") {
          Toast.show("Successfully Updated Profile Picture.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
          });
        } else {
          Toast.show("Failed to take picture.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  void walletTopUp() {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@dreamhome.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Top Up Wallet?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                WalletScreen(user: widget.user)));
                  },
                  child: new Text("Yes",
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.blue[400])),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No",
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.blue[400])),
                ),
              ]);
        });
  }
}
