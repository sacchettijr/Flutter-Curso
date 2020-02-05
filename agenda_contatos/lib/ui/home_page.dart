import 'dart:io';
import 'package:agenda_contatos/ui/contato_page.dart';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contatos_helper.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions {orderaz, orderza}

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
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>> [
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordernar de A-Z"),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordernar de Z-A"),
                value: OrderOptions.orderza,
              ),
            ],
            onSelected: _orderList,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPaginaContato();
        },
        child: Icon(
          Icons.add
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            return _contatoCard(context, index);
          },
        ),
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
              Expanded(
                child: Padding(
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
                          fontSize: 17.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        contatos[index].telefone ?? "",
                        style: TextStyle(
                          fontSize: 17.0,
                        ),  
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {

          },
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                          "Ligar",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                          ),
                      ),
                      onPressed: () {
                        launch("tel:${contatos[index].telefone}");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                          "Editar",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                          ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _showPaginaContato(contato: contatos[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                          "Excluir",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                          ),
                      ),
                      onPressed: () {
                        helper.deleteContato(contatos[index].id);
                        setState(() {
                          contatos.removeAt(index);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }

  void _showPaginaContato({Contato contato}) async {
    final recContato = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContatoPage(contato: contato,)
      ),
    );

    if (recContato != null) {
      if(contato != null) {
        await helper.atualizarContato(recContato);
        _getTodosContatos();
      } else {
        await helper.salvarContato(recContato);
      }
      _getTodosContatos();
    }
  }

  void _getTodosContatos() {
    helper.getTodosContatos().then((list){
      setState(() {
        contatos = list;
      });
    });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        contatos.sort((a, b) {
          return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contatos.sort((a, b) {
          return b.nome.toLowerCase().compareTo(a.nome.toLowerCase());
        });
        break;
      default:
    }
    setState(() {
      
    });
  }
}