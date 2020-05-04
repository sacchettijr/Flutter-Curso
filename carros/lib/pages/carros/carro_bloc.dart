import 'dart:async';
import 'package:carros/class/class_carro.dart';
import 'package:carros/pages/carros/carro_api.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();
  Stream<List<Carro>> get stream => _streamController.stream;

  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);

      return carros;
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
