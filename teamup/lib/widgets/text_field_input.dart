import 'package:flutter/material.dart';
import 'package:teamup/utils/colors.dart';

class TextFieldInput extends StatelessWidget {

  final TextEditingController textEditingController;
  final bool isPass;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;

  const TextFieldInput({super.key, required this.textEditingController, required this.textInputType, this.isPass = false, required this.labelText, required this.hintText});

  @override
  Widget build(BuildContext context) {

    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
        enabledBorder: inputBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: brandGreen, width: 1.0)
        )
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}