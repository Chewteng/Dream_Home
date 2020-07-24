import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dream_home/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
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
  GlobalKey<RefreshIndicatorState> refreshKey;
  List housedata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "House List";
  String housequantity = "0";
  int quantity = 1;
  var _tapPosition;
  String titlecenter = "Loading houses...";

  @override
  void initState() {
    super.initState();
    _loadData();
    refreshKey = GlobalKey<RefreshIndicatorState>();
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
          ],
        ),
        body: RefreshIndicator(
            key: refreshKey,
            color: Color.fromRGBO(101, 255, 218, 50),
            onRefresh: () async {
              await refreshList();
            },
            child: Container(
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              _sortHouse("Bungalow"),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              _sortHouse("Shoplot"),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      height: screenHeight / 12,
                      margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
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
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic),
                                    icon: Icon(Icons.search),
                                    labelText: "Search by State Name",
                                    border: OutlineInputBorder())),
                          ),
                          SizedBox(width: 40),
                          Flexible(
                              child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            color: Colors.blue[400],
                            textColor: Colors.white,
                            onPressed: () =>
                                {_sortHousebyAddress(_prdController.text)},
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
                          children: List.generate(housedata.length, (index) {
                    return Card(
                        child: InkWell(
                      onTap: () => _showPopupMenu(index),
                      onTapDown: _storePosition,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, bottom: 8),
                            height: 280,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 3,
                                      spreadRadius: 2)
                                ]),
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
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "http://yitengsze.com/cteng/homeimage/${housedata[index]['id']}.jpg?"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 15,
                                  left: 168,
                                  bottom: 10,
                                  right: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            housedata[index]['quantity'] +
                                            "/" +
                                            housedata[index]['book'],
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(MdiIcons.bedDoubleOutline),
                                          Text(
                                            housedata[index]['room'],
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Icon(MdiIcons.shower),
                                          Text(
                                            housedata[index]['broom'],
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Icon(MdiIcons.car),
                                          Text(
                                            housedata[index]['cpark'],
                                            style: TextStyle(
                                              color: Colors.white,
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
                                              housedata[index]['area'] +
                                                  " sqft",
                                              style: TextStyle(
                                                color: Colors.white,
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
            )),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.new_releases),
                label: "New House",
                labelBackgroundColor: Colors.white,
                onTap: createNewProduct),
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
        description: housedata[index]['description'],
        latitude: housedata[index]['latitude'],
        longitude: housedata[index]['longitude'],
        url: housedata[index]['url'],
        contact: housedata[index]['contact'],
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
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.update,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Update House Details?",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _deleteHouseDialog(index)},
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        MdiIcons.deleteAlert,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Delete House?",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
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
    http.post("https://yitengsze.com/cteng/php/delete_house.php", body: {
      "id": housedata[index]['id'],
    }).then((res) {
      print(res.body);

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
    });
  }

  void _loadData() async {
    String urlLoadHouses = "https://yitengsze.com/cteng/php/load_houses.php";
    await http.post(urlLoadHouses, body: {}).then((res) {
      if (res.body == "nodata") {
        housedata = null;
        titlecenter = "No houses found";

        Toast.show("No houses available in this location", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
    String urlLoadHouses = "https://yitengsze.com/cteng/php/load_houses.php";
    http.post(urlLoadHouses, body: {
      "type": type,
    }).then((res) {
      setState(() {
        if (res.body == "nodata") {
          housedata = null;
          titlecenter = "No houses found";
          Toast.show("No houses available in this location", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          //pr.dismiss();
        } else {
          curtype = type;
          var extractdata = json.decode(res.body);
          housedata = extractdata["houses"];
          FocusScope.of(context).requestFocus(new FocusNode());
        }
      });
    }).catchError((err) {
      print(err);
    });
  }

  void _sortHousebyAddress(String pradd) {
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
          });
        })
        .catchError((err) {});
  }

  Future<void> createNewProduct() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewHouse()));
    _loadData();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _loadData();
    return null;
  }
}
