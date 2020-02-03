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

  TextEditingController pesoControler = TextEditingController();
  TextEditingController alturaControler = TextEditingController();
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus dados";
  String _ideal = "";
  String _min = "";
  String _max = "";

  void _resetFields() {
    setState(() {
      pesoControler.text = "";
      alturaControler.text = "";
      _info = "Informe seus dados";
      _ideal = "";
      _min = "";
      _max = "";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoControler.text);
      double altura = double.parse(alturaControler.text) / 100;
      double imc = peso / (altura * altura);
      double _pesoMin = 19.5 * (altura * altura);
      double _pesoMedio = 22.0 * (altura * altura);
      double _pesoMax = 24.5 * (altura * altura);

      _ideal = "\nPESO IDEAL - ${_pesoMedio.toStringAsPrecision(3)} KG";
      _min = "\nPESO MÍNIMO - ${_pesoMin.toStringAsPrecision(3)} KG";
      _max = "\nPESO MÁXIMO - ${_pesoMax.toStringAsPrecision(3)} KG";

      if (imc < 15) {
        _info = "ABAIXO DO PESO\n(IMC = ${imc.toStringAsPrecision(3)})";
      } else if ( imc >= 18.5 && imc <= 24.9) {
        _info = "PESO NORMAL\n(IMC = ${imc.toStringAsPrecision(3)})";
      } else if ( imc >= 25.0 && imc <= 29.9) {
        _info = "SOBREPESO - GRAU I\n(IMC = ${imc.toStringAsPrecision(3)})";
      } else if ( imc >= 30.0 && imc <= 39.9) {
        _info = "OBESIDADE - GRAU II\n(IMC = ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _info = "OBESIDADE GRAVE - GRAU III\n(IMC = ${imc.toStringAsPrecision(3)})";
      } else {
        _info = "CALCULO INVÁLIDO!!!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg):",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
                controller: pesoControler,
                validator: (valor) {
                  if (valor.isEmpty){
                    return "Insira o seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm):",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
                controller: alturaControler,
                validator: (valor) {
                  if (valor.isEmpty){
                    return "Insira o sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0, 
                  bottom: 10.0
                ),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calcular();
                      }
                    },
                    child: Text("Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(_info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              Text(_ideal,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              Text(_min,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              Text(_max,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
              ),
              Icon(
                Icons.person_outline,
                size: 80.0,
                color: Colors.green,
              ),
            ],
          ),
        ),
      )
    );
  }
}