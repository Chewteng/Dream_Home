//import 'dart:async';
import 'dart:convert';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dream_home/user.dart';
import 'package:http/http.dart' as http;
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'edithouses.dart';
import 'house.dart';
import 'newhouse.dart';

class AdminHouses extends StatefulWidget {
  final User user;

  const AdminHouses({Key key, this.user}) : super(key: key);

  @override
  _AdminHousesState createState() => _AdminHousesState();
}

class _AdminHousesState extends State<AdminHouses> {
  List housedata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "House List";
  String housequantity = "0";
  int quantity = 1;
  //bool _isFavorited = false;
  var _tapPosition;
  String titlecenter = "Loading houses...";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    final formatter = new NumberFormat("#,###");

    if (housedata == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Manage Your Houses'),
          //backgroundColor: Color.fromRGBO(101, 255, 218, 50),
        ),
        body: Container(
            child: Center(
                child: Text(
          titlecenter,
          style: TextStyle(
              color: Colors.blue[400],
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ))),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Manage Your Houses'),
          // backgroundColor: Color.fromRGBO(101, 255, 218, 50),
          actions: <Widget>[
            IconButton(
              icon: _visible
                  ? new Icon(Icons.expand_more)
                  : new Icon(Icons.expand_less),
              onPressed: () {
                setState(() {
                  if (_visible) {
                    _visible = false;
                  } else {
                    _visible = true;
                  }
                });
              },
            ),

            //
          ],
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: _visible,
                child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      onPressed: () => _sortHouse("Recent"),
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.update,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Recent",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      onPressed: () =>
                                          _sortHouse("Condominium"),
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.homeCity,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Condominium",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      onPressed: () =>
                                          _sortHouse("Terraced House"),
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.homeGroup,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Terraced House",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      onPressed: () => _sortHouse("Bungalow"),
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.homeModern,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Bungalow",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      onPressed: () => _sortHouse("Flat"),
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.home,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Flat",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      onPressed: () => _sortHouse("Shoplot"),
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            MdiIcons.shoppingSearch,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "ShopLot",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ))),
              ),
              //Visibility(
              //visible: _visible,
              Card(
                elevation: 5,
                child: Container(
                  height: screenHeight / 12,
                  margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      //Flexible(
                      Container(
                        width: 230.0,
                        height: 35,
                        child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            autofocus: false,
                            controller: _prdController,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic),
                                icon: Icon(Icons.search),
                                labelText: "Search by State Name",
                                border: OutlineInputBorder())),
                      ),
                      SizedBox(width: 40),
                      //),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        color: Colors.blue[400],
                        textColor: Colors.white,
                        onPressed: () =>
                            {_sortHousebyAddress(_prdController.text)},
                        // elevation: 5,

                        child: Text("Search",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(curtype,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 5),
              Flexible(
                  child: ListView(
                      //crossAxisCount: 2,
                      // childAspectRatio: (screenWidth / screenHeight) / 0.8,
                      children: List.generate(housedata.length, (index) {
                return Card(
                    child: InkWell(
                  onTap: () => _showPopupMenu(index),
                  onTapDown: _storePosition,
                  //maxHeight: 300,
                  //  elevation: 10,
                  //  child: Padding(
                  // padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //margin: EdgeInsets.all(12),
                        // height: screenWidth / 4,
                        // width: screenWidth / 4,
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 8),
                        height: 280,
                        decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  spreadRadius: 2)
                            ]),

                        //height: MediaQuery.of(context).size.height/3,
                        child: Stack(children: <Widget>[
                          Positioned(
                            left: 2,
                            top: 8,
                            bottom: 5,
                            child: Container(
                                width: 160,
                                decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "http://yitengsze.com/cteng/homeimage/${housedata[index]['id']}.jpg",
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ))),
                          ),
                          Positioned(
                              top: 15,
                              left: 168,
                              bottom: 10,
                              right: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("SALE @ " + housedata[index]['type'],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 8),
                                  Text(housedata[index]['name'],
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(housedata[index]['address'],
                                      maxLines: 4,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 6),
                                  Text(
                                    "Price From",
                                    style: TextStyle(
                                      color: Colors.white,
                                      //fontSize: 17,
                                      //fontWeight: FontWeight.w900
                                    ),
                                  ),
                                  Text(
                                    "RM " +
                                        (formatter.format(int.parse(
                                            housedata[index]['price']))),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(height: 5),
                                   Text(
                                              "Available/Book Quantity: " +
                                                  housedata[index]
                                                      ['quantity'] +
                                                  "/" +
                                                  housedata[index]['book'],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                   SizedBox(height: 5),         
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(MdiIcons.bedDoubleOutline),
                                      Text(
                                        housedata[index]['room'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 17,
                                          // fontWeight: FontWeight.w900
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Icon(MdiIcons.shower),
                                      Text(
                                        housedata[index]['broom'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 17,
                                          // fontWeight: FontWeight.w900
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Icon(MdiIcons.car),
                                      Text(
                                        housedata[index]['cpark'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 17,
                                          // fontWeight: FontWeight.w900
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(MdiIcons.cropLandscape),
                                        SizedBox(width: 5),
                                        Text(
                                          housedata[index]['area'] + " sqft",
                                          style: TextStyle(
                                            color: Colors.white,
                                            //fontSize: 17,
                                            // fontWeight: FontWeight.w900
                                          ),
                                        ),
                                      ]),
                                ],
                              ))
                        ]),
                      ),
                    ],
                  ),
                  // )
                ));
              })))
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.new_releases),
                label: "New House",
                labelBackgroundColor: Colors.white,
                onTap: createNewProduct),
            SpeedDialChild(
                child: Icon(Icons.report),
                label: "Houses Report",
                labelBackgroundColor: Colors.white, //_changeLocality()
                onTap: () => null),
          ],
        ),
      );
    }
  }

  _onHouseDetail(int index) async {
    print(housedata[index]['name']);
    House house = new House(
        id: housedata[index]['id'],
        name: housedata[index]['name'],
        address: housedata[index]['address'],
        price: housedata[index]['price'],
        quantity: housedata[index]['quantity'],
        room: housedata[index]['room'],
        broom: housedata[index]['broom'],
        cpark: housedata[index]['cpark'],
        area: housedata[index]['area'],
        type: housedata[index]['type'],
        date: housedata[index]['date']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditHouses(
                  user: widget.user,
                  house: house,
                )));
    _loadData();
  }

  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      context: context,
      color: Colors.white,
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: [
        //onLongPress: () => _showPopupMenu(), //onLongTapCard(index),

        PopupMenuItem(
          child: GestureDetector(
              onTap: () => {Navigator.of(context).pop(), _onHouseDetail(index)},
              child: Text(
                "Update House Details?",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _deleteHouseDialog(index)},
              child: Text(
                "Delete House?",
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
      elevation: 8.0,
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _deleteHouseDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Delete House ID " + housedata[index]['id'],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content:
              new Text("Are you sure?", style: TextStyle(color: Colors.white)),
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
                _deleteHouse(index);
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

  void _deleteHouse(int index) {
    //ProgressDialog pr = new ProgressDialog(context,
   //     type: ProgressDialogType.Normal, isDismissible: false);
   // pr.style(message: "Deleting product...");
   // pr.show();
    http.post("https://yitengsze.com/cteng/php/delete_house.php", body: {
      "id": housedata[index]['id'],
    }).then((res) {
      print(res.body);
     /// pr.hide();
      if (res.body == "success") {
        Toast.show("Deleted successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadData();
        Navigator.of(context).pop();
      } else {
        Toast.show("Deleted failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
     // pr.hide();
    });
  }

 void _loadData() async {
    String urlLoadHouses = "https://yitengsze.com/cteng/php/load_houses.php";
    await http.post(urlLoadHouses, body: {}).then((res) {
      if (res.body == "nodata") {
        housedata = null;
        titlecenter = "No houses found";
        // titletop = "Carian menjumpai sebarang produk";

        Toast.show("No houses available in this location", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        //pr.dismiss();
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          housedata = extractdata["houses"];
          housequantity = widget.user.quantity;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _sortHouse(String type) {
    //try {
    // ProgressDialog pr = new ProgressDialog(context,
    //    type: ProgressDialogType.Normal, isDismissible: false);
    // pr.style(message: "Searching...");
    // pr.show();
    String urlLoadHouses = "https://yitengsze.com/cteng/php/load_houses.php";
    http.post(urlLoadHouses, body: {
      "type": type,
    }).then((res) {
      setState(() {
        if (res.body == "nodata") {
          housedata = null;
          titlecenter = "No houses found";
          // titletop = "Carian menjumpai sebarang produk";

          Toast.show("No houses available in this location", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          //pr.dismiss();
        } else {
          curtype = type;
          var extractdata = json.decode(res.body);
          housedata = extractdata["houses"];
          FocusScope.of(context).requestFocus(new FocusNode());
          // pr.dismiss();
        }
      });
    }).catchError((err) {
      print(err);
      // pr.dismiss();
    });
    //pr.dismiss();
    //} catch (e) {
    //  Toast.show("Error", context,
    //  //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }
  }

  void _sortHousebyAddress(String pradd) {
    //try {
    //  print(pradd);
    //  ProgressDialog pr = new ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: false);
    // pr.style(message: "Searching...");
    //  pr.show();
    String urlLoadHouses = "https://yitengsze.com/cteng/php/load_houses.php";
    http
        .post(urlLoadHouses, body: {
          "address": pradd.toString(),
        })
        .timeout(const Duration(seconds: 4))
        .then((res) {
          if (res.body == "nodata") {
            titlecenter = "No houses found";
            Toast.show("No houses found in this location", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            //pr.dismiss();
            FocusScope.of(context).requestFocus(new FocusNode());
            return;
          }
          setState(() {
            var extractdata = json.decode(res.body);
            housedata = extractdata["houses"];
            FocusScope.of(context).requestFocus(new FocusNode());
            curtype = pradd;
            // pr.dismiss();
          });
        })
        .catchError((err) {
          // pr.dismiss();
        });
    // pr.dismiss();
    // } on TimeoutException catch (_) {
    //  Toast.show("Time out", context,
    //      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //} on SocketException catch (_) {
    //  Toast.show("Time out", context,
    //      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //} catch (e) {
    //  Toast.show("Error", context,
    //      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }
  }

  Future<void> createNewProduct() async {
   await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewHouse()));
        _loadData();
  }

}
