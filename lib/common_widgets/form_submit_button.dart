import 'package:dexiheri/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    height: 44.0,
    color: Color(0xFF35a8ab),
    borderRadius: 4.0,
    onPressed: onPressed,
  );
}