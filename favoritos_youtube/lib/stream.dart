import 'dart:async';

void main() {

  List convidados = ["Junior", "Patrícia", "Sérgio", "Jéssica", "Paulo"];

  final controller = StreamController();

  final subscription =  controller.stream.where((data){
    return convidados.contains(data);
  }).listen((data) {
    print(data);
  });

  controller.sink.add("Daniel");
  controller.sink.add("Junior");
  controller.sink.add("Paulo");
  controller.sink.add("Jéssica");

  controller.close();
}