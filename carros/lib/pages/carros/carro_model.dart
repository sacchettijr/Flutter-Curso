import 'package:carros/class/class_carro.dart';
import 'package:carros/pages/carros/carro_api.dart';
import 'package:mobx/mobx.dart';

part 'carro_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  fetch(String tipo) async {
    try {
      error = null;
      this.carros = await CarrosApi.getCarros(tipo);
    } catch (e) {
      error = e;
    }
  }
}
