import 'dart:io';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contatos_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContatoHelper helper = ContatoHelper();

  List<Contato> contatos = List();

  @override
  void initState() {
    super.initState();
    _getTodosContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(
          Icons.add
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return _contatoCard(context, index);
        },
      ),
    );
  }

  Widget _contatoCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contatos[index].imagem != null ?
                      FileImage(File(contatos[index].imagem)) : 
                        AssetImage("imgs/profile_default.jpg"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contatos[index].nome ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),  
                    ),
                    Text(
                      contatos[index].email ?? "",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),  
                    ),
                    Text(
                      contatos[index].telefone ?? "",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),  
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getTodosContatos() {
    helper.getTodosContatos().then((list) {
      setState(() {
        contatos = list;
      });
    });
  }
}