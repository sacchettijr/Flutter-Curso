import 'dart:async';
import 'package:carros/class/class_carro.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/simple_bloc.dart';

class FavoritoBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();
      add(carros);
      return carros;
    } catch (e) {
      addError(e);
    }
  }
}
