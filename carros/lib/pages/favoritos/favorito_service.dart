import 'package:carros/class/class_carro.dart';
import 'package:carros/dao/dao_carro.dart';
import 'package:carros/class/class_favorito.dart';
import 'package:carros/dao/dao_favorito.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id);

    if (exists) {
      // Remove dos favoritos
      dao.delete(c.id);
      return false;
    } else {
      // Adiciona aos favoritos
      dao.save(f);
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query("SELECT * FROM carro c, favorito f WHERE c.id = f.id;");
    return carros;
  }

  static Future<bool> isFavorite(Carro c) async {
    final dao = FavoritoDAO();
    final bool exists = await dao.exists(c.id);

    return exists;
  }
}
