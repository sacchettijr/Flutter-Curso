import 'dart:async';
import 'package:http/http.dart' as http;

class LoremIpsumApi {
  static Future<String> getLoremIpsum() async {
    var url = 'https://loripsum.net/api';

    print(">>> GET: $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}

class LoremIpsumBloc {
  static String lorem;

  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    String s = lorem ?? await LoremIpsumApi.getLoremIpsum();

    lorem = s;

    _streamController.add(s);
  }

  void dispose() {
    _streamController.close();
  }
}
