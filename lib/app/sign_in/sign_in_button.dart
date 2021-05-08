import 'package:dexiheri/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';

class SignInButton extends CustomRaisedButton{
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
}) : assert( text != null),
        super(
    child: Text(text, style: TextStyle(color: textColor, fontSize: 18.0)),
    color: color,
    onPressed: onPressed,
  );
}