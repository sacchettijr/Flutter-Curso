import 'package:carros/class/class_carro.dart';
import 'package:carros/pages/carros/carro_listview.dart';
import 'package:carros/pages/favoritos/favorito_bloc.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    FavoritoBloc favoritosBloc = Provider.of<FavoritoBloc>(
      context,
      listen: false,
    );

    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: Provider.of<FavoritoBloc>(context).stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(
            "Não foi possível buscar os carros",
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(
            carros,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritoBloc>(context).fetch();
  }
}
