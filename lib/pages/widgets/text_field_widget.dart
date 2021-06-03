import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController tController;
  final bool password;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.tController,
    this.password = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tController,
      obscureText: password,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 25,
          color: Colors.grey,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.green,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          // borderSide: BorderSide.lerp(
          //   BorderSide(color: Colors.lightBlue.shade50, width: 16),
          //   BorderSide(width: 16, color: Colors.lightBlue.shade900),
          //   0.1,
          // ),
        ),
      ),
      validator: validator,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
    );
  }
}
