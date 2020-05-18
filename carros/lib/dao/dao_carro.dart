import 'package:carros/class/class_carro.dart';
import 'package:carros/utils/database/dao_base.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    return query('SELECT * FROM carro WHERE tipo =? ', [tipo]);
  }
}
