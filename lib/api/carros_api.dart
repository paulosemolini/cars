import 'dart:convert' as convert;

import 'package:carros/model/carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carros>> getCarros() async {
    var url =
        Uri.parse('https://carros-springboot.herokuapp.com/api/v1/carros');
    var response = await http.get(url);
    String json = response.body;

    List list = convert.json.decode(json);

    //Boas práticas

    List<Carros> carros = list.map((e) => Carros.fromJson(e)).toList();

    //Metodo não boas práticas
    //final List<Carros> carros = [];
    // for (Map<String, dynamic> map in list) {
    //   Carros c = Carros.fromJson(map);
    //   carros.add(c);
    // }
    //
    return carros;

    //Metodo antigo.
    // final List<Carros> carros = [];
    //
    // await Future.delayed(
    //   Duration(seconds: 2),
    // );
    //
    // carros.add(Carros(
    //     nome: "Ferrari FF 2",
    //     urlFoto:
    //         'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png'));
    // carros.add(Carros(
    //     nome: "AUDI GT Spyder",
    //     urlFoto:
    //         'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Audi_Spyder.png'));
    // carros.add(Carros(
    //     nome: "Porsche Panamera",
    //     urlFoto:
    //         'https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Porsche_Panamera.png'));
    //
    // return carros;
  }
}
