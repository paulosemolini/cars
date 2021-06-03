import 'package:carros/pages/widgets/app_button.dart';
import 'package:carros/pages/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tLogin = TextEditingController(text: 'Paulo');

  final TextEditingController _tSenha = TextEditingController(text: '12');

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carros'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFieldWidget(
              labelText: 'Login',
              hintText: 'Informe o usuário',
              tController: _tLogin,
              validator: _validatorLogin,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: "Login",
            //     labelStyle: TextStyle(
            //       fontSize: 25,
            //       color: Colors.grey,
            //     ),
            //     hintText: "Informe o usuário",
            //     hintStyle: TextStyle(
            //       fontSize: 16,
            //       color: Colors.green,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              tController: _tSenha,
              labelText: "Senha",
              hintText: "Informe a senha.",
              password: true,
              validator: _validatorSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            // TextFormField(
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: "Senha",
            //     labelStyle: TextStyle(
            //       fontSize: 25,
            //       color: Colors.grey,
            //     ),
            //     hintText: "Informe a senha",
            //     hintStyle: TextStyle(
            //       fontSize: 16,
            //       color: Colors.green,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            _button('Login', _onClickLogin),
          ],
        ),
      ),
    );
  }

  _button(String text, Function() onPressed) {
    return AppButton(text, onPressed: onPressed);
    // return Container(
    //   height: 46,
    //   child: ElevatedButton(
    //     onPressed: onPressed,
    //     child: Text(
    //       text,
    //       style: TextStyle(
    //         fontSize: 25,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // );
  }

  _onClickLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    debugPrint("Login: $login, Senha: $senha");
  }

  String? _validatorLogin(String? value) {
    String t = value ?? '';
    if (t.isEmpty) {
      return 'Informe o usuário';
    }
    return null;
  }

  String? _validatorSenha(String? value) {
    String t = value ?? '';
    if (t.isEmpty) {
      return 'Digite a senha';
    }
    if (t.length < 3) {
      return 'A senha precisa ter pelo menos 3 números';
    }
    return null;
  }
}
