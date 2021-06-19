import 'dart:convert';

import 'package:carros/commons/api_response.dart';
import 'package:carros/webservice/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  //static Future<Usuario> login(String login, String senha) async {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      //var url = Uri.parse('http://livrowebservices.com.br/rest/login');
      var url =
          Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');

      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {
        'username': login,
        'password': senha,
      };

      String params_convert = json.encode(params);

      var response =
          await http.post(url, body: params_convert, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        //return user;
        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      debugPrint("Erro no login $error > $exception");
      return ApiResponse.error('Não foi possível fazer o login');
    }
  }
}
