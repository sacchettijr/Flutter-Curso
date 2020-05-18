import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/class/class_carro.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/lorem_ipsum.dart';
import 'package:flutter/material.dart';
import 'package:carros/widgets/text.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  CarroPage(
    this.carro,
  );

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loremIpsumBloc = LoremIpsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorite(carro).then((bool favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });

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
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto,
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
                color: color,
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

  void _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void _onClickCompartilhar() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar");
        break;
      case "Deletar":
        print("Deletar");
        break;
      case "Compartilhar":
        print("Compartilhar");
        break;
    }
  }
}
