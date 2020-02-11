import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          child: FlareActor(
            "assets/gears-spin.flr",
            animation: "spin",
            isPaused: false,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 3,)
    ).then((_){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Hello Flare",
            style: TextStyle(
              fontSize: 30.0,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 100,
            width: 100,
            child: FlareActor(
              "assets/heart.flr",
              animation: "Batida",
            ),
          ),
          Container(
            height: 100,
            width: 100,
            child: FlareActor(
              "assets/robotic-arm.flr",
              animation: "pegar",
            ),
          ),
        ],
      ),
    );
  }
}