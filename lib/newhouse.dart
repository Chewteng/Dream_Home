import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

class NewHouse extends StatefulWidget {
  @override
  _NewHouseState createState() => _NewHouseState();
}

class _NewHouseState extends State<NewHouse> {
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  TextEditingController priceEditingController = new TextEditingController();
  TextEditingController qtyEditingController = new TextEditingController();
  TextEditingController roomEditingController = new TextEditingController();
  TextEditingController broomEditingController = new TextEditingController();
  TextEditingController carparkEditingController = new TextEditingController();
  TextEditingController areaEditingController = new TextEditingController();
  TextEditingController typeEditingController = new TextEditingController();
  TextEditingController descEditingController = new TextEditingController();
  TextEditingController latEditingController = new TextEditingController();
  TextEditingController logEditingController = new TextEditingController();
  TextEditingController urlEditingController = new TextEditingController();
  TextEditingController contactEditingController = new TextEditingController();
  double screenHeight, screenWidth;
  File _image;
  var _tapPosition;
  String _scanBarcode = 'Click here to get house ID';
  String pathAsset = 'assets/images/camera.png';
  String server = "https://yitengsze.com/cteng";
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();
  final focus9 = FocusNode();
  final focus10 = FocusNode();
  final focus11 = FocusNode();
  final focus12 = FocusNode();
  String selectedType;
  List<String> listType = [
    "Condominium",
    "Terraced House",
    "Bungalow",
    "Shoplot",
    "Flat",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('New House'),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 6),
                GestureDetector(
                    onTap: () => {_choose()},
                    child: Container(
                      height: screenHeight / 4.0,
                      width: screenWidth / 1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                    )),
                SizedBox(height: 5),
                Text("Click the above image to take picture of your house",
                    style: TextStyle(fontSize: 10.0, color: Colors.white)),
                SizedBox(height: 5),
                Container(
                    width: screenWidth / 1.2,
                    //height: screenHeight / 2,
                    child: Card(
                        elevation: 6,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Table(
                                    defaultColumnWidth: FlexColumnWidth(1.0),
                                    columnWidths: {
                                      0: FlexColumnWidth(4.0),
                                      1: FlexColumnWidth(5.0),
                                    },
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("House ID",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                        TableCell(
                                          child: Container(
                                              height: 30,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 30,
                                                child: GestureDetector(
                                                    onTap: _showPopupMenu,
                                                    onTapDown: _storePosition,
                                                    child: Text(
                                                      _scanBarcode,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              )),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("House Name",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    nameEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),

                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Address",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    addressEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus0,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus1);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),

                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Price (RM)",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    priceEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus1,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus2);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Quantity (Unit)",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    qtyEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus2,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus3);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Type",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 40,
                                            child: Container(
                                              height: 40,
                                              child: DropdownButton(
                                                //sorting dropdownoption
                                                hint: Text(
                                                  'Type',
                                                  style: TextStyle(
                                                      color: Colors.blue[400]),
                                                ), // Not necessary for Option 1
                                                value: selectedType,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedType = newValue;
                                                    print(selectedType);
                                                  });
                                                },
                                                items: listType
                                                    .map((selectedType) {
                                                  return DropdownMenuItem(
                                                    child: new Text(
                                                        selectedType,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blue[400])),
                                                    value: selectedType,
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Room",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    roomEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus3,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus4);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("BathRoom",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    broomEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus4,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus5);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("CarPark",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    carparkEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus5,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus6);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Area (sqft)",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    areaEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus6,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus7);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Description",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    descEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus7,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus8);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),

                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Latitude",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    latEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus8,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus9);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Longitude",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    logEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus9,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus10);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("House URL",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    urlEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus10,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus11);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Contact No.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                controller:
                                                    contactEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus11,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus12);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.white,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                  //fillColor: Colors.green
                                                )),
                                          ),
                                        ),
                                      ]),
                                    ]),
                                SizedBox(height: 3),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  minWidth: screenWidth / 1.5,
                                  height: 40,
                                  child: Text(
                                    'Insert New House Details',
                                    style: TextStyle(
                                        //fontSize: 16,

                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.blue[400],
                                  textColor: Colors.black,
                                  elevation: 5,
                                  onPressed: _insertNewHouse,
                                ),
                              ],
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _choose() async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    if (_image == null) {
      Toast.show("No image is pictured.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: _image.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Cropper',
          ));
      if (croppedFile != null) {
        _image = croppedFile;
        setState(() {});
      }
    }
  }

  void _onGetId() {
    scanBarcodeNormal();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        _scanBarcode = "Click here to get house ID";
      } else {
        _scanBarcode = barcodeScanRes;
      }
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void _insertNewHouse() {
    if (_scanBarcode == "Click here to get house ID") {
      Toast.show("Please insert house ID", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (_image == null) {
      Toast.show("Please take house picture", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (nameEditingController.text.length < 1) {
      Toast.show("Please insert house name", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (qtyEditingController.text.length < 1) {
      Toast.show("Please insert house quantity available", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (addressEditingController.text.length < 2) {
      Toast.show("Please insert house address completely", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (priceEditingController.text.length < 1) {
      Toast.show("Please insert house price", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (areaEditingController.text.length < 1) {
      Toast.show("Please insert house area", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (roomEditingController.text.length < 1) {
      Toast.show("Please insert house room available", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (broomEditingController.text.length < 1) {
      Toast.show("Please insert house bathroom available", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (carparkEditingController.text.length < 1) {
      Toast.show("Please insert house carpark available", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (descEditingController.text.length < 1) {
      Toast.show("Please insert house brief decription", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (latEditingController.text.length < 1) {
      Toast.show("Please insert house latitude", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (logEditingController.text.length < 1) {
      Toast.show("Please insert house longitude", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (urlEditingController.text.length < 1) {
      Toast.show("Please insert house url", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (contactEditingController.text.length < 1) {
      Toast.show("Please insert contact number", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Insert New House Name " + nameEditingController.text,
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
                insertHouse();
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

  insertHouse() {
    if (_image == null) {
      Toast.show("No image is pictured.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      String base64Image = base64Encode(_image.readAsBytesSync());
      http.post(server + "/php/insert_house.php", body: {
        "id": _scanBarcode,
        "name": nameEditingController.text,
        "address": addressEditingController.text,
        "quantity": qtyEditingController.text,
        "price": priceEditingController.text,
        "room": roomEditingController.text,
        "broom": broomEditingController.text,
        "cpark": carparkEditingController.text,
        "type": selectedType,
        "area": areaEditingController.text,
        "description": descEditingController.text,
        "latitude": latEditingController.text,
        "longitude": logEditingController.text,
        "url": urlEditingController.text,
        "contact": contactEditingController.text,
        "encoded_string": base64Image,
      }).then((res) {
        print(res.body);

        if (res.body == "success") {
          print("Insert Successfully.");
          Toast.show("Insert successfully", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.of(context).pop();
        } else {
          print("Insert Failed.");
          Toast.show("Insert failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  _showPopupMenu() async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
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
              onTap: () => {Navigator.of(context).pop(), _onGetId()},
              child: Text(
                "Scan Barcode",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () => {Navigator.of(context).pop(), scanQR()},
              child: Text(
                "Scan QR Code",
                style: TextStyle(color: Colors.black),
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () => {Navigator.of(context).pop(), _manCode()},
              child: Text(
                "Manual",
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

  _manCode() {
    TextEditingController pridedtctrl = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Enter House ID ",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: new Container(
            margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
            height: 30,
            child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                controller: pridedtctrl,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: new InputDecoration(
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                )),
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
                setState(() {
                  if (pridedtctrl.text.length > 3) {
                    _scanBarcode = pridedtctrl.text;
                  } else {}
                });
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
}
