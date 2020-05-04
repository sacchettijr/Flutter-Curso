import 'package:carros/class/class_carro.dart';
import 'package:carros/utils/lorem_ipsum.dart';
import 'package:flutter/material.dart';
import 'package:carros/widgets/text.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loremIpsumBloc = LoremIpsumBloc();

  @override
  void initState() {
    super.initState();

    _loremIpsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.place,
            ),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(
              Icons.videocam,
            ),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton(
            onSelected: _onClickPopupMenu,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: text(
                    "Editar",
                  ),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: text(
                    "Deletar",
                  ),
                ),
                PopupMenuItem(
                  value: "Compartilhar",
                  child: text(
                    "Compartilhar",
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(
            widget.carro.urlFoto,
          ),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(
              widget.carro.nome,
              fontSize: 20,
              bold: true,
            ),
            text(
              widget.carro.tipo,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickCompartilhar,
            ),
          ],
        ),
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(
          widget.carro.descricao,
          fontSize: 16,
          bold: true,
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loremIpsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return text(
              snapshot.data,
              fontSize: 16,
            );
          },
        ),
        text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  void _onClickFavorito() {}

  void _onClickCompartilhar() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar - ${value}");
        break;
      case "Deletar":
        print("Deletar - ${value}");
        break;
      case "Compartilhar":
        print("Compartilhar - ${value}");
        break;
    }
  }
}
