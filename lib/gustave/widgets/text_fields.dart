import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO convert to class
Widget _buildTextFieldImpl(TextEditingController controller, String hint,
    String? Function(String?) validator, bool obscure, List formatters) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextFormField(
      inputFormatters: formatters as List<TextInputFormatter>?,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 3.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
        ),
        hintText: hint,
      ),
      validator: validator,
      obscureText: obscure,
    ),
  );
}

Widget buildTextField(TextEditingController controller, String hint,
    {bool obscure = false}) {
  return _buildTextFieldImpl(
      controller, hint, (value) => null, obscure, <TextInputFormatter>[]);
}

Widget buildValidatedTextField(TextEditingController controller, String hint,
    String? Function(String?) validator,
    {bool obscure = false}) {
  return _buildTextFieldImpl(
      controller, hint, validator, obscure, <TextInputFormatter>[]);
}
