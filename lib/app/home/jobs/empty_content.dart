import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = 'Δεν υπάρχουν διαθέσιμα καταστήματα',
    this.message = 'Προσθέστε νέο κατάστημα για να ξεκινήσετε',
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        Text(message, style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ],
    );
  }
}
