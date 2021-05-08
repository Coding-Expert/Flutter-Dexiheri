import 'package:dexiheri/app/models/job.dart';
import 'package:flutter/material.dart';

class JobListTile extends StatelessWidget {
  const JobListTile({Key key, @required this.job, this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child:
                Image.asset('assets/images/house2.png', height: 100, width: 60),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title:Text(
                  job.nameKatastimatos,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),

              trailing: Icon(Icons.chevron_right, color: Colors.white),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
