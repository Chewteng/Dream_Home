import 'package:flutter/material.dart';
import "dart:math";

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  final double padding = 10.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isEnabled = true;
  double principal, payment, interest, months;
  var rates = [5, 10, 15, 18];
  var dpRate = 18; //dpRate = down payment rate
  double principalRate = 0.00;
  double dpAmount = 0.00;
  double paymentRate = 0.00;
  double monthlyResult = 0.00;
  double totalResult = 0.00;
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();

  @override
  void initState() {
    super.initState();
    dpRate = rates[3];
  }

  TextEditingController principalEditingController = new TextEditingController();
  TextEditingController paymentEditingController = new TextEditingController();
  TextEditingController interestEditingController = new TextEditingController();
  TextEditingController yearsEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Mortgage Calculator'),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(padding * 2),
              padding: EdgeInsets.fromLTRB(2, 5, 5, 10),
              child: Column(
                children: <Widget>[
                  new Image.asset(
                    'assets/images/money.png',
                    width: 300.0,
                    height: 135.0,
                  ),
                  SizedBox(height: 30),
                  //Widget getDownPaymentRateDropDown(),
                  Padding(
                    padding: EdgeInsets.only(left: 9),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Down Payment Rate',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Expanded(
                          child: DropdownButton<int>(
                            items: rates.map((rate) {
                              return DropdownMenuItem<int>(
                                value: rate,
                                child: Text(
                                  '$rate %',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (rate) {
                              if (rate != dpRate)
                                setState(() {
                                  dpRate = rate;
                                  principalEditingController.clear();
                                  paymentEditingController.clear();
                                  interestEditingController.clear();
                                  yearsEditingController.clear();
                                });
                            },
                            value: dpRate,
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focus0);
                        },
                        onChanged: (value) {
                          setState(() {
                            principalRate =
                                value.length > 0 ? double.parse(value) : 0;
                            double payment = (principalRate * dpRate / 100);
                            paymentEditingController.text =
                                payment.toStringAsFixed(2);
                          });
                        },
                        controller: principalEditingController,
                        decoration: InputDecoration(
                            hintText: 'Enter Property Price e.g. 500000',
                            labelText: 'Property Price (RM)',
                            labelStyle: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            hintStyle: TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        validator: _validateValue,
                        onSaved: (value) {
                          principal = double.parse(value);
                        },
                      )),
                  Padding(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _isEnabled = !_isEnabled;
                        });
                      },
                      controller: paymentEditingController,
                      enabled: _isEnabled,
                      decoration: InputDecoration(
                          hintText: 'Enter Down payment e.g. 5,000',
                          labelText: 'Down Payment (RM)',
                          labelStyle: new TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          hintStyle: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: _validateValue,
                      onSaved: (value) {
                        payment = double.parse(value);
                      },
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),
                  Padding(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: focus0,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus1);
                      },
                      controller: interestEditingController,
                      decoration: InputDecoration(
                          hintText: 'In percentage e.g 10',
                          labelText: 'Interest Rate (%)',
                          labelStyle: new TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          hintStyle: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: _validateValue,
                      onSaved: (value) {
                        interest = double.parse(value);
                      },
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),
                  Padding(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: focus1,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus2);
                      },
                      controller: yearsEditingController,
                      decoration: InputDecoration(
                          hintText: 'e.g 2',
                          labelText: 'Loan Term (Years)',
                          hintStyle: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          labelStyle: new TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      validator: _validateValue,
                      onSaved: (value) {
                        months = double.parse(value);
                      },
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text('Calculate',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          color: Colors.blue[400],
                          //textColor: Colors.black,

                          onPressed: _handleSubmitted,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: RaisedButton(
                          child: Text('Reset',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          color: Colors.blue[400],
                          //textColor: Colors.white,
                          onPressed: resetValues,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.fromLTRB(70, 0, 50, 0),
                      child: Table(
                          defaultColumnWidth: FlexColumnWidth(1.0),
                          columnWidths: {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(5),
                          },
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child:
                                    Text('${monthlyResult.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                              )),
                              TableCell(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 30,
                                      child: Text("Monthly",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)))),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: Text('${totalResult.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white)),
                              )),
                              TableCell(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 30,
                                      child: Text("Total Payment",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white)))),
                            ])
                          ])),
                ],
              ),
            ),
          ),
        ));
  }

  String _validateValue(String value) {
    if (value == null || value.isEmpty) return "This field is required";
    return null;
  }

  resetValues() {
    principalEditingController.text = "";
    paymentEditingController.text = "";
    interestEditingController.text = "";
    yearsEditingController.text = "";
    setState(() {
      monthlyResult = 0.00;
      totalResult = 0.00;
    });
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      //showInSnackBar("This field is required");
      return;
    } else
      form.save();
    calculateValues();
  }

  calculateValues() {
    double interestRate = interest / 12 / 100;
    double periods = months * 12;

    setState(() {
      totalResult = principal - payment;
      monthlyResult = (totalResult *
          interestRate *
          pow((1 + interestRate), periods) /
          (pow((1 + interestRate), periods) - 1));
    });
  }
}
