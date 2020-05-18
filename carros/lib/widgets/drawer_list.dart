import 'package:carros/class/class_usuario.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: user.urlFoto != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.urlFoto),
            )
          : FlutterLogo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    var children2 = <Widget>[
      FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          Usuario user = snapshot.data;
          return user != null ? _header(user) : Container();
        },
      ),
      ListTile(
        leading: Icon(
          Icons.star,
        ),
        title: Text(
          "Favoritos",
        ),
        subtitle: Text("mais informações"),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.help,
        ),
        title: Text(
          "Ajuda",
        ),
        subtitle: Text("mais informações"),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.exit_to_app,
        ),
        title: Text(
          "Sair",
        ),
        subtitle: Text("mais informações"),
        onTap: () {
          _onClickLogout(context);
        },
      ),
    ];
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: children2,
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
