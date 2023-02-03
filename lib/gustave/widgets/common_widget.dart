import 'package:flutter/material.dart';

class CommonForm extends Center {
  CommonForm(BuildContext context, Widget widget)
      : super(
            child: FractionallySizedBox(
                widthFactor: getWidthFactor(context), child: widget));

  static double getWidthFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const maxWidth = 1200;
    const minWidth = 600;
    if (screenWidth > maxWidth) {
      return 0.3;
    } else if (screenWidth < minWidth) {
      return 0.9;
    } else {
      return 0.3 + (1200 - screenWidth) / 1000;
    }
  }
}

class Button extends Padding {
  Button(String text, void Function()? callback)
      : super(
          padding: EdgeInsets.all(8.0),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors.white;
              }),
              backgroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors.blue;
              }),
            ),
            onPressed: callback,
            child: Text(text),
          ),
        );
}

class BaseTextField extends Padding {
  BaseTextField(
    String hint,
    TextEditingController controller,
    String? Function(String?) validator,
    bool obscure,
  ) : super(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 3.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 3.0),
                ),
                hintText: hint,
              ),
              validator: validator,
              obscureText: obscure,
            ));
}

class BasicTextField extends BaseTextField {
  BasicTextField(String hint, TextEditingController controller)
      : super(
          hint,
          controller,
          (value) => null,
          false,
        );
}

class ObscuredTextField extends BaseTextField {
  ObscuredTextField(String hint, TextEditingController controller)
      : super(
          hint,
          controller,
          (value) => null,
          true,
        );
}

class ValidatedTextField extends BaseTextField {
  ValidatedTextField(
    String hint,
    TextEditingController controller,
    String? Function(String?) validator,
  ) : super(
          hint,
          controller,
          validator,
          false,
        );
}

class ObscuredValidatedTextField extends BaseTextField {
  ObscuredValidatedTextField(
    String hint,
    TextEditingController controller,
    String? Function(String?) validator,
  ) : super(
          hint,
          controller,
          validator,
          true,
        );
}

void displayError(BuildContext context, String text) {
  final bar = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(bar);
}
