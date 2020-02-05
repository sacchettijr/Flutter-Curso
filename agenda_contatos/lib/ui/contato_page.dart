import 'dart:async';
import 'package:agenda_contatos/helpers/contatos_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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

  final _nomeFocus = FocusNode();

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
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            _editandoContato.nome ?? "Novo contato"
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editandoContato.nome != null && _editandoContato.nome.isNotEmpty){
              Navigator.pop(context, _editandoContato);
            } else {
              FocusScope.of(context).requestFocus(_nomeFocus);
            }
          },
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
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.camera).then((file){
                    if (file == null) return;
                    setState(() {
                      _editandoContato.imagem = file.path;
                    });
                  });
                },
              ),
              TextField(
                controller: _nomeController,
                focusNode: _nomeFocus,
                decoration: InputDecoration(
                  labelText: "Nome"
                ),
                onChanged: (text) {
                  _userEditou = true;
                  setState(() {
                    _editandoContato.nome = text;
                  });
                },
                keyboardType: TextInputType.text,
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
                controller: _telefoneController,
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
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEditou) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Descartar alterações?"),
            content: Text("Se sair as alterações serão perdidas."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Confirmar"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}