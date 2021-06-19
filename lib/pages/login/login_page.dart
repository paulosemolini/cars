import 'package:carros/commons/api_response.dart';
import 'package:carros/commons/nav.dart';
import 'package:carros/pages/homepage/home_page.dart';
import 'package:carros/pages/widgets/app_button.dart';
import 'package:carros/pages/widgets/text_field_widget.dart';
import 'package:carros/webservice/login_api.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tLogin = TextEditingController(text: 'user');

  final TextEditingController _tSenha = TextEditingController(text: '123');

  final _focusSenha = FocusNode();

  bool _showProgress = false;

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
          padding: EdgeInsets.only(
            bottom: 8,
            left: 8,
            right: 8,
            top: 16,
          ),
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
            //_button('Login', _onClickLogin),
            AppButton(
              'Login',
              onPressed: _onClickLogin,
              showProgress: _showProgress,
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    debugPrint("Login: $login, Senha: $senha");

    setState(() {
      _showProgress = true;
    });

    //bool ok = await LoginApi.login(login, senha);
    ApiResponse response = await LoginApi.login(login, senha);

    //if (ok) {
    if (response.ok) {
      push(context, HomePage());
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext dialogContext) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Alerta'),
              content: Text(response.msg),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
    setState(() {
      _showProgress = false;
    });
  }
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
