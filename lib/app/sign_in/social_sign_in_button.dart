import 'package:dexiheri/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';

class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : assert(text !=null),
       assert(assetName != null),
        super(
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(assetName),
        Text(text,style: TextStyle(color: textColor, fontSize: 18.0)),
        Opacity(opacity: 0.0, child: Image.asset(assetName)),
      ],
    ),
    color: color,
    onPressed: onPressed,
  );
}