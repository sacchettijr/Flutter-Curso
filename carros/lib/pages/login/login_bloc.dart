import 'dart:async';
import 'package:carros/utils/simple_bloc.dart';
import 'package:carros/utils/api_response.dart';
import 'package:carros/class/class_usuario.dart';
import 'package:carros/pages/login/login_api.dart';

class LoginBloc extends BooleanBloc{
  Future<ApiResponse<Usuario>> login(
    String login,
    String senha,
  ) async {
    add(true);

    ApiResponse response = await LoginApi.login(
      login,
      senha,
    );

    add(false);

    return response;
  }
}
