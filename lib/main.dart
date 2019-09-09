import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Enter your data";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Enter your data";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 17) {
        _infoText = "Very underweight (${imc.toStringAsPrecision(3)})";
      } else if (imc > 17 && imc <= 18.49) {
        _infoText = "Underweight (${imc.toStringAsPrecision(3)})";
      } else if (imc > 18.49 && imc <= 24.99) {
        _infoText = "Normal (${imc.toStringAsPrecision(3)})";
      } else if (imc > 24.99 && imc <= 29.99) {
        _infoText = "Overweight (${imc.toStringAsPrecision(3)})";
      } else if (imc > 29.99 && imc <= 34.99) {
        _infoText = "Obesity I (${imc.toStringAsPrecision(3)})";
      } else if (imc > 34.99 && imc <= 39.99) {
        _infoText = "Obesity II - Severe (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesity III - Morbid (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IMC Calculator"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 130.0,
                color: Colors.blue,
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "weight (kg)",
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter your weight";
                    }
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "height (cm)",
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter your heigth";
                    }
                  },
                ),
              ),
              
              Container(
                height: 50.0,
                margin: EdgeInsets.all(15),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                  child: Text("Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  color: Colors.blue,
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
