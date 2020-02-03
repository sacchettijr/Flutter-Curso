import 'package:agenda_contatos/helpers/contatos_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ContatoPage extends StatefulWidget {

  final Contato contato;

  ContatoPage({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  bool _userEditou;

  Contato _editandoContato;

  @override
  void initState() {
    super.initState();

    if (widget.contato == null) {
      _editandoContato = Contato();
    } else {
      _editandoContato = Contato.fromMap(widget.contato.toMap());

      _nomeController.text = _editandoContato.nome;
      _emailController.text = _editandoContato.email;
      _telefoneController.text = _editandoContato.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          _editandoContato.nome ?? "Novo contato"
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.save,
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editandoContato.imagem != null ?
                      FileImage(File(_editandoContato.imagem)) : 
                        AssetImage("imgs/profile_default.jpg"),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
              onChanged: (text) {
                _userEditou = true;
                setState(() {
                  _editandoContato.nome = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-mail"
              ),
              onChanged: (text) {
                _userEditou = true;
                _editandoContato.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Telefone"
              ),
              onChanged: (text) {
                _userEditou = true;
                _editandoContato.telefone = text;
              },
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}