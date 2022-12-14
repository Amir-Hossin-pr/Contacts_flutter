import 'package:flutter/material.dart';

class InputOutline extends StatelessWidget {
  final String hint;
  final String lable;
  final TextInputType inputTtype;
  final TextEditingController controller;
  final String errorText;

  const InputOutline(
      {super.key,
      required this.hint,
      required this.controller,
      required this.lable,
      required this.errorText,
      this.inputTtype = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
            validator: (value) =>
                value == null || value.isEmpty ? errorText : null,
            controller: controller,
            keyboardType: inputTtype,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: hint,
                labelText: lable)));
  }
}
