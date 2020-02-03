import 'package:flutter/material.dart';

void main(){
	runApp(MaterialApp(
		title: "Contador de Pessoas",
		home: Home(),
	));
}

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	int _pessoa = 0;
	String _infoTexto = "Pode entrar!";

	void _mudarPessoa(int delta){
		setState(() {
		  	_pessoa += delta;

			if (_pessoa < 0) {
				_infoTexto = "Mundo Invertido?!";
			} else if (_pessoa >= 0 && _pessoa < 10) {
				_infoTexto = "Pode entrar!";
			} else {
				_infoTexto = "LOTADO!";
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		return Stack(
			children: <Widget>[
				Image.asset(
					"imgs/wallpaper.jpg",
					fit: BoxFit.cover,
					width: 1000.0,
				),
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text("MEU PRIMEIRO APP",
							style: TextStyle(
								color: Colors.white,
								fontWeight: FontWeight.bold,
								fontSize: 40.0,
							),
						),
						Text("Pessoas: $_pessoa",
							style: TextStyle(
								color: Colors.white,
								fontWeight: FontWeight.bold,
								fontSize: 30.0,
							),
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								Padding(
									padding: EdgeInsets.all(10.0),
									child: FlatButton(
										child: Text("+1",
											style: TextStyle(
												fontSize: 40.0, 
												color: Colors.white,
											),
										),
										onPressed: () {
											_mudarPessoa(1);
										},
									),
								),
								Padding(
									padding: EdgeInsets.all(10.0),
									child: FlatButton(
										child: Text("-1",
											style: TextStyle(
												fontSize: 40.0, 
												color: Colors.white,
											),
										),
										onPressed: () {
											_mudarPessoa(-1);
										},
									),
								),
							],
						),
						Text(_infoTexto,
							style: TextStyle(
								color: Colors.white,
								fontStyle: FontStyle.italic,
								fontSize: 30.0,
							),
						)
					],
				)
			],
		);
	}
}