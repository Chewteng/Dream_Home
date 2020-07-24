import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'book.dart';
import 'package:http/http.dart' as http;

class BookingDetailsScreen extends StatefulWidget {
  final Book book;

  const BookingDetailsScreen({Key key, this.book}) : super(key: key);
  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  List _bookdetails;
  String titlecenter = "Loading booking details...";
  double screenHeight, screenWidth;
  String server = "https://yitengsze.com/cteng";
  int downpayment = 0;
  int unitSelected;
  double servicecharge;

  @override
  void initState() {
    super.initState();
    _loadBookDetails();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final formatter = new NumberFormat("#,###");

    return Scaffold(
      appBar: AppBar(
        title: Text('House Booking Details'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text(
            "Booking Details",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            child: Column(children: <Widget>[
              SizedBox(
                height: 3,
              ),
              Row(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Booking ID: ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        widget.book.bookid,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ],
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Paid on " + widget.book.date,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ]),
          ),
          _bookdetails == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ))))
              : Expanded(
                  child: ListView.builder(
                      //Step 6: Count the data
                      itemCount:
                          _bookdetails == null ? 0 : _bookdetails.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _bookdetails.length) {
                          return Container(
                              child: Card(
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                  child: Table(
                                      defaultColumnWidth: FlexColumnWidth(1.0),
                                      columnWidths: {
                                        0: FlexColumnWidth(8),
                                        1: FlexColumnWidth(3),
                                      },
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    "Down Payment RM200/unit ",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))),
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
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    "Total Selected (Unit) ",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))),
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
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text("Service Charge ",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white))),
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
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text("Total Payment ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.white))),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 20,
                                              child: Text(
                                                  "RM " + widget.book.total,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ]),
                                      ]),
                                ),
                                SizedBox(height: 10),
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
                                  Text(
                                    (index + 1).toString() + ".",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 8),
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
                                                  "http://yitengsze.com/cteng/homeimage/${_bookdetails[index]['id']}.jpg?"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Text(
                                        _bookdetails[index]['id'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      child: Container(
                                    height: screenWidth / 4,
                                    color: Colors.grey,
                                  )),
                                  Container(
                                      width: screenWidth / 1.8,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _bookdetails[index]['name'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  "RM " +
                                                      (formatter.format(
                                                          double.parse(
                                                              _bookdetails[
                                                                      index]
                                                                  ['price']))),
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
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "x" +
                                                          _bookdetails[index]
                                                              ['hquantity'],
                                                      style: TextStyle(
                                                        height: 2.0,
                                                        color: Colors.white,
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
                      }))
        ]),
      ),
    );
  }

  _loadBookDetails() async {
    downpayment = 0;
    unitSelected = 0;
    String urlLoadBookDetails = server + "/php/load_bookinghistory.php";
    await http.post(urlLoadBookDetails, body: {
      "bookid": widget.book.bookid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        setState(() {
          _bookdetails = null;
          titlecenter = "No Any Payment Made";
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          _bookdetails = extractdata["bookhistory"];
          for (int i = 0; i < _bookdetails.length; i++) {
            unitSelected =
                int.parse(_bookdetails[i]['hquantity']) + unitSelected;
            downpayment = unitSelected * 200;
          }
          servicecharge = double.parse(widget.book.total) - downpayment;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
