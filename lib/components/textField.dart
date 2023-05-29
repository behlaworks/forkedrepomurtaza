import 'package:flutter/material.dart';

import '../data/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final IconData? icon;
  final bool obscure;
  final String hint;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.inputAction,
      required this.inputType,
      this.validator,
      this.icon,
      required this.obscure, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscure,
        controller: controller,
        textInputAction: inputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: inputType,
        style: TextStyle(
          color: Constants.dark,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: Constants.dark,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle:  const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            icon: Icon(
              icon,
              color: Constants.dark,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Constants.dark),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Constants.grey),
                borderRadius: BorderRadius.circular(8)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Constants.grey),
        validator: validator);
  }
}
