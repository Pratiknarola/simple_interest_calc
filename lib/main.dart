import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple interest calculator",
    home: SIform(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ["Rupees", "Dollars", "Pounds", "Yens"];
  final _minPadding = 5.0;
  var CurrentSelected = "Rupees";

  TextEditingController principleController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var _Result = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calc"),
      ),
      body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(_minPadding * 2.0),
            child: ListView(
              children: <Widget>[
                getAssetImage(),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: TextFormField(
                    style: textStyle,
                    decoration: InputDecoration(
                        labelText: 'Principle',
                        hintText: 'Enter principle e.g. 12000',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.number,
                    controller: principleController,
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please enter principle amount';
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: TextFormField(
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please enter rate of Interest';
                      }
                    },
                    style: textStyle,
                    decoration: InputDecoration(
                        labelText: 'Rate of interest',
                        hintText: '% rate e.g. 10%',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.number,
                    controller: rateController,
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            validator: (String value){
                              if (value.isEmpty){
                                return 'Please enter time';
                              }
                              if (! isNumeric(value)){
                                return 'Enter only digits';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'time in years',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent,
                                    fontSize: 15.0
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: termController,
                          ),
                        ),
                        Container(
                          width: _minPadding * 5.0,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                                items: _currencies.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: CurrentSelected,
                                onChanged: (String newValueSelected) {
                                  //CurrentSelected = newValueSelected;
                                  setState(() {
                                    CurrentSelected = newValueSelected;
                                  });
                                })),
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text(
                              "Calculate",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if(_formkey.currentState.validate()) {
                                  this._Result = _calculateTotalReturns();
                                }
                              });
                            },
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        Container(
                          width: _minPadding * 2,
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Reset",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Container(
                  child: Text(
                    this._Result,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  padding: EdgeInsets.all(_minPadding * 5),
                )
              ],
            ),
          )),
    );
  }

  Widget getAssetImage() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  String _calculateTotalReturns() {
    double principle = double.parse(principleController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double amountpayable = principle + (principle * rate * term) / 100;

    return "After $term years total payable amount is $amountpayable $CurrentSelected";
  }

  void _reset() {
    principleController.text = "";
    termController.text = '';
    rateController.text = '';
    _Result = "";
    CurrentSelected = _currencies[0];
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
