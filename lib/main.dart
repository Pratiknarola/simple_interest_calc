import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Simple interest calculator", home: SIform()));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  var _currencies = ["Rupees", "Dollars", "Pounds", "Yens"];
  final _minPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calc"),
      ),
      body: Container(
        margin: EdgeInsets.all(_minPadding * 2),
        child: Column(
          children: <Widget>[
            getAssetImage(),
            Padding(
              padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Principle',
                    hintText: 'Enter principle e.g. 12000',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Rate of interest',
                    hintText: '% rate e.g. 10%',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            Row(
              children: <Widget>[

              ],
            )

          ],
        ),
      ),
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
}
