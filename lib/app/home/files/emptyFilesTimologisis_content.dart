import 'package:flutter/material.dart';

class EmptyFilesTimologisisContent extends StatelessWidget {
  const EmptyFilesTimologisisContent({Key key,
    this.title = 'Δεν υπάρχουν αρχεία',
    this.message = 'Προσθέστε νέα αρχεία'}) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 20.0, color: Colors.black54),
          ),
          Text(message, style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
