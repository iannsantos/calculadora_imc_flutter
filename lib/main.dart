import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Insira seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Insira seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 17) {
        _infoText = "Muito abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 17 && imc <= 18.49) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 18.49 && imc <= 24.99) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      } else if (imc > 24.99 && imc <= 29.99) {
        _infoText = "Acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 29.99 && imc <= 34.99) {
        _infoText = "Obesidade I (${imc.toStringAsPrecision(3)})";
      } else if (imc > 34.99 && imc <= 39.99) {
        _infoText = "Obesidade II - Severa (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade III - Mórbida (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
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
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight (kg)",
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Height (cm)",
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                },
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.all(15),
                child: RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                  child: Text("Calcular",
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
