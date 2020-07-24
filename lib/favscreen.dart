import 'dart:convert';
import 'package:dream_home/mainscreen.dart';
import 'package:dream_home/payment.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dream_home/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class FavScreen extends StatefulWidget {
  final User user;

  const FavScreen({Key key, this.user}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List favData;
  double screenHeight, screenWidth;
  bool _isabellaService = true;
  bool _storeCredit = false;
  bool _jeffreryService = false;
  bool _lunaService = false;
  double _totalprice = 0.0;
  int downpayment = 0;
  int unitSelected;
  double servicecharge;
  double amountpayable;

  @override
  void initState() {
    super.initState();
    _loadFav();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final formatter = new NumberFormat("#,###");

    return Scaffold(
        appBar: AppBar(title: Text('My Favourites'), actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.deleteEmpty),
            onPressed: () {
              deleteAll();
            },
          ),
        ]),
        body: Container(
            child: Column(children: <Widget>[
          Text(
            "Content of favourite",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          favData == null
              ? Flexible(
                  child: Container(
                      child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 160, 10, 10),
                          child: Image.asset(
                            'assets/images/saved.jpg',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "No favourites shortlisted yet!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Save a property by tapping on the love",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "button of any listing property.",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                )))
              : Expanded(
                  child: ListView.builder(
                      itemCount: favData == null ? 1 : favData.length + 3,
                      itemBuilder: (context, index) {
                        if (index == favData.length + 1) {
                          return Container(
                              color: Colors.grey,
                              child: InkWell(
                                onLongPress: () => {print("Delete")},
                                child: Column(children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Agent Service Option",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  Card(
                                      color: Colors.grey,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Checkbox(
                                                          checkColor: Colors
                                                                  .blue[
                                                              400], // color of tick Mark
                                                          activeColor:
                                                              Colors.blue[400],

                                                          value:
                                                              _isabellaService,
                                                          onChanged:
                                                              (bool value) {
                                                            _onIsabellaService(
                                                                value);
                                                          },
                                                        ),
                                                        Text("Isabella",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            minWidth: 60,
                                                            minHeight: 80,
                                                            maxWidth: 60,
                                                            maxHeight: 80,
                                                          ),
                                                          child: Image.asset(
                                                              "assets/images/isabella.jpg",
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                                "My value is present",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Text(
                                                                "you a property at the",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Text(
                                                                "most professional way.",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 0, 4, 1),
                                                    child: SizedBox(
                                                        width: 2,
                                                        child: Container(
                                                          height:
                                                              screenWidth / 3.0,
                                                          color: Colors.grey,
                                                        ))),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Checkbox(
                                                          checkColor: Colors
                                                                  .blue[
                                                              400], // color of tick Mark
                                                          activeColor:
                                                              Colors.blue[400],
                                                          value:
                                                              _jeffreryService,
                                                          onChanged:
                                                              (bool value) {
                                                            _onJefferyService(
                                                                value);
                                                          },
                                                        ),
                                                        Text("Jeffrery",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            minWidth: 60,
                                                            minHeight: 80,
                                                            maxWidth: 60,
                                                            maxHeight: 80,
                                                          ),
                                                          child: Image.asset(
                                                              "assets/images/jeffrery.png",
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                                "My value is serve ",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Text(
                                                                "you wholeheartedly",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Text(
                                                                "with the best service.",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 1, 4, 1),
                                                    child: SizedBox(
                                                        width: 2,
                                                        child: Container(
                                                          height:
                                                              screenWidth / 3.0,
                                                          color: Colors.grey,
                                                        ))),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Checkbox(
                                                          checkColor: Colors
                                                                  .blue[
                                                              400], // color of tick Mark
                                                          activeColor:
                                                              Colors.blue[400],
                                                          value: _lunaService,
                                                          onChanged:
                                                              (bool value) {
                                                            _onLunaService(
                                                                value);
                                                          },
                                                        ),
                                                        Text("Luna",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            minWidth: 60,
                                                            minHeight: 80,
                                                            maxWidth: 60,
                                                            maxHeight: 80,
                                                          ),
                                                          child: Image.asset(
                                                              "assets/images/luna.jpg",
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Column(
                                                          children: <Widget>[
                                                            Text(
                                                                "My value is fulfill ",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Text(
                                                                "your needs at best",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Text(
                                                                "and patience in enquiry.",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                )),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                          .blue[
                                                                      400],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      ))
                                ]),
                              ));
                        }
                        if (index == favData.length) {
                          return Container(
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Column(children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 10, 50, 10),
                                        //color: Colors.red,
                                        child: Table(
                                            defaultColumnWidth:
                                                FlexColumnWidth(1.0),
                                            columnWidths: {
                                              0: FlexColumnWidth(7),
                                              1: FlexColumnWidth(5),
                                            },
                                            children: [
                                              TableRow(children: [
                                                TableCell(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 20,
                                                      child: Text(
                                                          "Total House Price ",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white))),
                                                ),
                                                TableCell(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 20,
                                                    child: Text(
                                                        "RM " +
                                                                _totalprice
                                                                    .toStringAsFixed(
                                                                        2) ??
                                                            "0.0",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              ]),
                                            ]))
                                  ])));
                        }

                        if (index == favData.length + 2) {
                          return Container(
                              child: Card(
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Pre-Book House Payment",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(height: 10),
                                Container(
                                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                    //color: Colors.red,
                                    child: Table(
                                        defaultColumnWidth:
                                            FlexColumnWidth(1.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(8),
                                          1: FlexColumnWidth(3),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "Down Payment RM200/unit ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.white))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    "RM " +
                                                            downpayment
                                                                .toString() ??
                                                        "0",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "Total Selected (Unit) ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.white))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    unitSelected.toString() ??
                                                        "0 unit",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text("Service Charge ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.white))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    "RM " +
                                                            servicecharge
                                                                .toStringAsFixed(
                                                                    2) ??
                                                        "0",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text(
                                                      "Store Credit - RM " +
                                                          widget.user.credit,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.white))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Checkbox(
                                                  checkColor: Colors.blue[
                                                      400], // color of tick Mark
                                                  activeColor: Colors.blue[400],
                                                  value: _storeCredit,
                                                  onChanged: (bool value) {
                                                    _onStoreCredit(value);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text("Total Payment ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color:
                                                              Colors.white))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    "RM " +
                                                            amountpayable
                                                                .toStringAsFixed(
                                                                    2) ??
                                                        "0.0",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ]),
                                        ])),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          MdiIcons.bankTransfer,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Make Payment",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    color: Colors.blue[400],
                                    textColor: Colors.white,
                                    elevation: 10,
                                    onPressed: makePayment,
                                  ),
                                ),
                              ],
                            ),
                          ));
                        }

                        index -= 0;
                        return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            elevation: 10,
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: screenWidth / 3,
                                        width: screenWidth / 3,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[400],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://yitengsze.com/cteng/homeimage/${favData[index]['id']}.jpg?"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Text(
                                          "RM " +
                                              (formatter.format(double.parse(
                                                  favData[index]['price']))),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                      child: SizedBox(
                                          //width: 4,
                                          child: Container(
                                        height: screenWidth / 2.5,
                                        color: Colors.grey,
                                      ))),
                                  Container(
                                      width: screenWidth / 1.8,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  favData[index]['type'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  favData[index]['name'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    height: 1.5,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        favData[index]
                                                                ['quantity'] +
                                                            " unit",
                                                        style: TextStyle(
                                                          height: 2.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        " Left",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 2.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ]),
                                                Container(
                                                    height: 20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          onPressed: () => {
                                                            _updateFav(
                                                                index, "add")
                                                          },
                                                          child: Icon(
                                                            MdiIcons.plus,
                                                            color: Colors
                                                                .blue[400],
                                                          ),
                                                        ),
                                                        Text(
                                                          favData[index]
                                                              ['hquantity'],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () => {
                                                            _updateFav(
                                                                index, "remove")
                                                          },
                                                          child: Icon(
                                                            MdiIcons.minus,
                                                            color: Colors
                                                                .blue[400],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Text(
                                                        "Total RM " +
                                                            (formatter.format(double
                                                                .parse(favData[
                                                                        index][
                                                                    'yourprice']))),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                    Spacer(),
                                                    FlatButton(
                                                      onPressed: () =>
                                                          {_deleteFav(index)},
                                                      child: Icon(
                                                        MdiIcons.delete,
                                                        color: Colors.blue[400],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ])));
                      }),
                )
        ])));
  }

  void _loadFav() {
    _totalprice = 0.0;
    unitSelected = 0;
    amountpayable = 0.0;
    servicecharge = 0.0;

    String urlLoadFav = "https://yitengsze.com/cteng/php/load_fav.php";
    http.post(urlLoadFav, body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);

      NumberFormat format = NumberFormat("#,###");

      if (res.body == "Favourite List Empty") {
        //Navigator.of(context).pop(false);
        Toast.show("Favourite List Empty", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        widget.user.quantity = "0";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(
                      user: widget.user,
                    )));
      }

      setState(() {
        var extractdata = json.decode(res.body);
        favData = extractdata["favourite"];
        for (int i = 0; i < favData.length; i++) {
          _totalprice = double.parse(favData[i]['yourprice']) + _totalprice;
          unitSelected = int.parse(favData[i]['hquantity']) + unitSelected;
        }

        _totalprice = _totalprice;
        print(format.format(_totalprice));
      });
      Toast.show("Updated fav list successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }).catchError((err) {
      print(err);
    });
  }

  _updateFav(int index, String op) {
    int curquantity = int.parse(favData[index]['quantity']);
    int quantity = int.parse(favData[index]['hquantity']);
    if (op == "add") {
      quantity++;
      if (quantity > curquantity) {
        Toast.show("Sold Out", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
    }
    if (op == "remove") {
      quantity--;
      if (quantity == 0) {
        _deleteFav(index);
        return;
      }
    }
    String urlUpdateFav = "https://yitengsze.com/cteng/php/update_fav.php";
    http.post(urlUpdateFav, body: {
      "email": widget.user.email,
      "houseid": favData[index]['id'],
      "quantity": quantity.toString()
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("List Updated", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadFav();
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _deleteFav(int index) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Remove ' + favData[index]['name'] + ' from favourite list?',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post("https://yitengsze.com/cteng/php/delete_fav.php",
                    body: {
                      "email": widget.user.email,
                      "houseid": favData[index]['id'],
                    }).then((res) {
                  print(res.body);
                  if (res.body == "success") {
                    _loadFav();
                  } else {
                    Toast.show("Failed", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                }).catchError((err) {
                  print(err);
                });
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "No",
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  void _onIsabellaService(bool newValue) => setState(() {
        _isabellaService = newValue;
        if (_isabellaService) {
          _jeffreryService = false;
          _lunaService = false;
          _updatePayment();
        } else {
          _updatePayment();
        }
      });

  void _onStoreCredit(bool newValue) => setState(() {
        _storeCredit = newValue;
        if (_storeCredit) {
          _updatePayment();
        } else {
          _updatePayment();
        }
      });

  void _onJefferyService(bool newValue) => setState(() {
        _jeffreryService = newValue;
        if (_jeffreryService) {
          _updatePayment();
          _isabellaService = false;
          _lunaService = false;
        } else {
          _updatePayment();
        }
      });

  void _onLunaService(bool newValue) => setState(() {
        _lunaService = newValue;
        if (_lunaService) {
          _updatePayment();
          _isabellaService = false;
          _jeffreryService = false;
        } else {
          _updatePayment();
        }
      });

  void _updatePayment() {
    downpayment = 0;
    unitSelected = 0;
    _totalprice = 0.0;
    amountpayable = 0.0;
    setState(() {
      for (int i = 0; i < favData.length; i++) {
        _totalprice = double.parse(favData[i]['yourprice']) + _totalprice;
        unitSelected = int.parse(favData[i]['hquantity']) + unitSelected;
        downpayment = unitSelected * 200;
      }
      if (_lunaService) {
        if (unitSelected > 5) {
          servicecharge = unitSelected * 5.50;
        } else if (unitSelected > 10) {
          servicecharge = unitSelected * 6.00;
        } else {
          servicecharge = 25.00;
        }
      }
      if (_jeffreryService) {
        if (unitSelected > 5) {
          servicecharge = unitSelected * 5.30;
        } else if (unitSelected > 10) {
          servicecharge = unitSelected * 5.50;
        } else {
          servicecharge = 22.00;
        }
      }
      if (_isabellaService) {
        if (unitSelected > 5) {
          servicecharge = unitSelected * 5.00;
        } else if (unitSelected > 8) {
          servicecharge = unitSelected * 6.00;
        } else {
          servicecharge = 22.00;
        }
      }
      //amountpayable = servicecharge;
      if (_storeCredit) {
        amountpayable =
            downpayment + servicecharge - double.parse(widget.user.credit);
      } else {
        amountpayable = downpayment + servicecharge;
      }
      print(_storeCredit);
      print(_totalprice);
    });
  }

  void makePayment() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Are you sure you want to make payment' + '?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                _makePayment();
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

  Future<void> _makePayment() async {
    if (amountpayable < 0) {
      double newamount = amountpayable * -1;
      print(amountpayable);
      print(newamount);
      await _payusingstorecredit(newamount);
      _loadFav();
      return;
    }
    if (_lunaService) {
      print("Luna Service");
      Toast.show("Luna Service", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (_jeffreryService) {
      print("Jeffrery Service");
      Toast.show("Jeffrery Service", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (_isabellaService) {
      print("Isabella Service");
      Toast.show("Isabella Service", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Please select agent service option", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhms');
    String bookid = formatter.format(now) + randomAlphaNumeric(10);
    print(bookid);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(
                  user: widget.user,
                  val: amountpayable.toStringAsFixed(2),
                  bookid: bookid,
                )));
    _loadFav();
  }

  String generateBookingID() {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhms');
    String bookid = formatter.format(now) + randomAlphaNumeric(10);
    return bookid;
  }

  Future<void> _payusingstorecredit(double newamount) async {
    //insert carthistory
    //remove cart content
    //update product quantity
    //update credit in user
    String updateamount = newamount.toStringAsFixed(2);
    Toast.show("Updating Favourite List", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    String urlPayment = "https://yitengsze.com/cteng/php/paymentwallet.php";
    await http.post(urlPayment, body: {
      "userid": widget.user.email,
      "amount": (downpayment + servicecharge).toStringAsFixed(2),
      "bookid": generateBookingID(),
      "newcr": updateamount
    }).then((res) {
      print(res.body);
      if (res.body == "Success pay with DreamHome wallet") {
        print("Success.");
        setState(() {
          widget.user.credit = updateamount;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void deleteAll() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Delete all items?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post("https://yitengsze.com/cteng/php/delete_fav.php",
                    body: {
                      "email": widget.user.email,
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadFav();
                  } else {
                    Toast.show("Failed to delete house", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                }).catchError((err) {
                  print(err);
                });
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
}
