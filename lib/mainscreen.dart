import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dream_home/dialog_helper.dart';
import 'package:dream_home/infopage.dart';
import 'package:dream_home/wallethistory.dart';
import 'package:flutter/material.dart';
import 'package:dream_home/registerscreen.dart';
import 'package:dream_home/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'favscreen.dart';
import 'package:dream_home/calculator.dart';
import 'package:intl/intl.dart';
import 'package:dream_home/loginscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'house.dart';
import 'paymenthistoryscreen.dart';
import 'profilescreen.dart';
import 'adminhouses.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List housedata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "House List";
  String housequantity = "0";
  int quantity = 1;
  bool _isadmin = false;
  String titlecenter = "Loading houses...";
  String server = "https://yitengsze.com/cteng";

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadHouseQuantity();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    if (widget.user.email == "admin@dreamhome.com") {
      _isadmin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    final formatter = new NumberFormat("#,###");

    if (housedata == null) {
      return Scaffold(
          appBar: AppBar(title: Text('Dream Home')
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
            )),
          ));
    } else {
      return WillPopScope(
          onWillPop: () async {
            return await DialogHelper.exit(context);
          },
          child: Scaffold(
            drawer: mainDrawer(context),
            appBar: AppBar(
              title: Text('Dream Home'),
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
            body: RefreshIndicator(
                key: refreshKey,
                color: Color.fromRGBO(101, 255, 218, 50),
                onRefresh: () async {
                  await refreshList();
                },
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              onPressed: () =>
                                                  _sortHouse("Recent"),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              onPressed: () =>
                                                  _sortHouse("Flat"),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
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
                          fit: FlexFit.tight,
                          child: ListView(
                              children:
                                  List.generate(housedata.length, (index) {
                            return Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => _onImageDisplay(index),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 8),
                                      height: 280,
                                      decoration: BoxDecoration(
                                          // shape: BoxShape.circle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: server +
                                                        "/homeimage/${housedata[index]['id']}.jpg",
                                                    placeholder: (context,
                                                            url) =>
                                                        new CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    "SALE @ " +
                                                        housedata[index]
                                                            ['type'],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                SizedBox(height: 8),
                                                Text(housedata[index]['name'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    housedata[index]['address'],
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                SizedBox(height: 6),
                                                Text(
                                                  "Price From",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "RM " +
                                                      (formatter.format(
                                                          int.parse(
                                                              housedata[index]
                                                                  ['price']))),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                    "Quantity Available: " +
                                                        housedata[index]
                                                            ['quantity'] +
                                                        " Unit",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 6),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(MdiIcons
                                                        .bedDoubleOutline),
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Icon(MdiIcons
                                                          .cropLandscape),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        housedata[index]
                                                                ['area'] +
                                                            " sqft",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      IconButton(
                                                          icon: Icon(Icons
                                                              .favorite_border),
                                                          onPressed: () =>
                                                              _addtofavdialog(
                                                                  index)),
                                                    ]),
                                              ],
                                            ))
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              // )
                            );
                          })))
                    ],
                  ),
                )),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FavScreen(
                              user: widget.user,
                            )));
                _loadData();
                _loadHouseQuantity();
              },
              icon: Icon(Icons.favorite),
              label: Text(housequantity),
            ),
          ));
    }
  }

  _onImageDisplay(int index) async {
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
    House house = new House(
      id: housedata[index]["id"],
      price: housedata[index]["price"],
      type: housedata[index]["type"],
      quantity: housedata[index]["quantity"],
      area: housedata[index]["area"],
      room: housedata[index]["room"],
      broom: housedata[index]["broom"],
      cpark: housedata[index]["cpark"],
      name: housedata[index]["name"],
      description: housedata[index]["description"],
      latitude: housedata[index]["latitude"],
      longitude: housedata[index]["longitude"],
      url: housedata[index]["url"],
      contact: housedata[index]["contact"],
      address: housedata[index]["address"],
      imagename: housedata[index]["imagename"],
    );

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => InfoPage(
                  house: house,
                )));

    _loadData();
  }

  void _loadData() async {
    String urlLoadHouses = server + "/php/load_houses.php";
    await http.post(urlLoadHouses, body: {}).then((res) {
      if (res.body == "nodata") {
        housequantity = "0";
        titlecenter = "No houses found";
        setState(() {
          housedata = null;
        });
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

  void _loadHouseQuantity() async {
    String urlLoadFavQuantity = server + "/php/load_favquantity.php";
    await http.post(urlLoadFavQuantity, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
      } else {
        widget.user.quantity = res.body;
      }
    }).catchError((err) {
      print(err);
    });
  }

  Widget mainDrawer(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.blue[400],
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
                color: Colors.blue[400],
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/drawer.jpg',
                    ),
                    fit: BoxFit.cover)),
            accountName: Text(widget.user.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            accountEmail: Text(widget.user.email,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            otherAccountsPictures: <Widget>[
              Text("RM " + widget.user.credit,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ))
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.android
                      ? Colors.white70
                      : Colors.white70,
              child: Text(
                widget.user.name.toString().substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 40.0),
              ),
              backgroundImage: NetworkImage(
                  "http://yitengsze.com/cteng/profileimages/${widget.user.email}.jpg?"),
            ),
            onDetailsPressed: () => {
              Navigator.pop(context),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(
                            user: widget.user,
                          )))
            },
          ),
          Card(
            child: ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child:
                      Image.asset("assets/images/main.png", fit: BoxFit.cover),
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "Back to homepage",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                isThreeLine: true,
                dense: true,
                trailing: Icon(Icons.arrow_forward),
                onTap: () => {
                      Navigator.pop(context),
                      _loadData(),
                    }),
          ),
          Card(
              child: ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 44,
                      maxHeight: 44,
                    ),
                    child: Image.asset("assets/images/calculator.png",
                        fit: BoxFit.cover),
                  ),
                  title: Text(
                    "Mortgage Calculator",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "Calculate monthly repayments for any property",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  isThreeLine: true,
                  dense: true,
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    if (widget.user.email == "admin@dreamhome.com") {
                      Toast.show("Admin Mode!!!", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      return;
                    } else {
                      //Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Calculator()));
                    }
                  })),
          Card(
            child: ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Image.asset("assets/images/favorite.png",
                      fit: BoxFit.cover),
                ),
                title: Text(
                  "Favourites",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "Saved preferences listing here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                isThreeLine: true,
                dense: true,
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  if (widget.user.email == "admin@dreamhome.com") {
                    Toast.show("Admin Mode!!!", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  } else {
                    Navigator.pop(context);
                    gotoFav();
                  }
                }),
          ),
          Card(
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 44,
                  maxHeight: 44,
                ),
                child:
                    Image.asset("assets/images/booking.jpg", fit: BoxFit.cover),
              ),
              title: Text(
                "House Booking",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "House Booking Details & Payment History here",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              isThreeLine: true,
              dense: true,
              trailing: Icon(Icons.arrow_forward),
              onTap: _paymentScreen,
            ),
          ),
          Card(
            child: ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 44,
                  maxHeight: 44,
                ),
                child:
                    Image.asset("assets/images/wallet.png", fit: BoxFit.cover),
              ),
              title: Text(
                "Wallet TopUp",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Wallet balance & its transactions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              isThreeLine: true,
              dense: true,
              trailing: Icon(Icons.arrow_forward),
              onTap: _walletScreen,
            ),
          ),
          Card(
            child: ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Image.asset("assets/images/settings.png",
                      fit: BoxFit.cover),
                ),
                title: Text(
                  "User Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "App and privacy settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                isThreeLine: true,
                dense: true,
                trailing: Icon(Icons.arrow_forward),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProfileScreen(
                                    user: widget.user,
                                  )))
                    }),
          ),
          Card(
            child: ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Image.asset("assets/images/register.png",
                      fit: BoxFit.cover),
                ),
                title: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  "Register new account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                isThreeLine: true,
                dense: true,
                trailing: Icon(Icons.arrow_forward),
                onTap: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterScreen()))
                    }),
          ),
          Card(
              child: ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 44,
                      maxHeight: 44,
                    ),
                    child: Image.asset("assets/images/logout.png",
                        fit: BoxFit.cover),
                  ),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "Back to loginscreen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  isThreeLine: true,
                  dense: true,
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  })),
          Visibility(
            visible: _isadmin,
            child: Column(
              children: <Widget>[
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                Center(
                  child: Text(
                    "Admin Menu",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: ListTile(
                      title: Text(
                        "My House List",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () => {
                            Navigator.pop(context),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AdminHouses(
                                          user: widget.user,
                                        )))
                          }),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  _addtofavdialog(int index) {
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
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + housedata[index]['name'] + " as Favourite?",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        server + "/homeimage/${housedata[index]['id']}.jpg",
                    width: 220,
                    height: 180,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Select house quantity",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Colors.blue[400],
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity <
                                    (int.parse(housedata[index]['quantity']))) {
                                  quantity++;
                                } else {
                                  Toast.show("Sold Out", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Colors.blue[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      _addtoFav(index);
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
            );
          });
        });
  }

  void _addtoFav(int index) {
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
    try {
      int fquantity = int.parse(housedata[index]["quantity"]);
      print(fquantity);
      print(housedata[index]["id"]);
      print(widget.user.email);
      if (fquantity > 0) {
        String urlInsertFav = server + "/php/insert_fav.php";
        http.post(urlInsertFav, body: {
          "email": widget.user.email,
          "houseid": housedata[index]["id"],
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            Toast.show("Failed add to fav", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            //pr.dismiss();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              housequantity = respond[1];
              widget.user.quantity = housequantity;
            });
            Toast.show("Success add to fav", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        }).catchError((err) {
          print(err);
        });
      } else {
        Toast.show("Sold Out", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Failed add to fav", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _sortHouse(String type) {
    try {
      String urlLoadHouses = server + "/php/load_houses.php";
      http.post(urlLoadHouses, body: {
        "type": type,
      }).then((res) {
        setState(() {
          if (res.body == "nodata") {
            housedata = null;
            titlecenter = "No houses found";
            // titletop = "Carian menjumpai sebarang produk";
            curtype = type;
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
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _sortHousebyAddress(String pradd) {
    try {
      String urlLoadHouses = server + "/php/load_houses.php";
      http
          .post(urlLoadHouses, body: {
            "address": pradd.toString(),
          })
          .timeout(const Duration(seconds: 4))
          .then((res) {
            if (res.body == "nodata") {
              Toast.show("Address not found", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

              print("Address not found");
              setState(() {
                titlecenter = "No houses found";
                curtype = "Search for " + "'" + pradd + "'";
                housedata = null;
                print("Address not found");
              });
              FocusScope.of(context).requestFocus(new FocusNode());
              return;
            }
            setState(() {
              var extractdata = json.decode(res.body);
              housedata = extractdata["houses"];
              FocusScope.of(context).requestFocus(new FocusNode());
              curtype = "Search for " + "'" + pradd + "'";
            });
          })
          .catchError((err) {});
    } on TimeoutException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } on SocketException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  gotoFav() async {
    if (widget.user.email == "unregistered@dreamhome.com") {
      Toast.show("Please signup to unlock this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@dreamhome.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.quantity == "0") {
      Toast.show("Favourite List Empty", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FavScreen(
                    user: widget.user,
                  )));
      _loadData();
      _loadHouseQuantity();
    }
  }

  void _paymentScreen() {
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
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentHistoryScreen(
                  user: widget.user,
                )));
  }

  void _walletScreen() {
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
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => WalletScreen(
                  user: widget.user,
                )));
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _loadData();
    return null;
  }
}
