import 'package:carros/utils/database/dao_base.dart';
import 'package:carros/class/class_favorito.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";
}
