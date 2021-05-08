import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexiheri/app/home/jobs/edit_job_page.dart';
import 'package:dexiheri/app/home/jobs/job_list_tile.dart';
import 'package:dexiheri/app/home/jobs/list_items_builder.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/posts/allPosts.dart';
import 'package:dexiheri/common_widgets/show_alert_dialog.dart';
import 'package:dexiheri/common_widgets/show_exception_alert_dialog.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:dexiheri/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobsPage extends StatelessWidget {
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@dexiheri.gr',
      queryParameters: {
        'subject': 'Dexiheri App'
      }
  );

 Future<void> _delete(BuildContext context, Job job) async{
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e){
      showExceptionAlertDialog(context, title: 'Μήνυμα λάθους', exception: e);
    }
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF302e2f),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF302e2f),
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        primary: Color(0xFF598fbb),
                        padding:
                            EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostsScreen()),
                      );
                    },
                    child: Text('Ενημερώσεις για θέματα που αφορούν τα ΚΥΕ',
                        style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        primary: Color(0xFF598fbb),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 5.0)),
                    onPressed: (){
                      launch(_emailLaunchUri.toString());
                    },
                    child: Text('Επικοινωνία με Κορωνάκη',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Title(
              color: Colors.white,
              child: Text(
                'ΕΠΙΛΟΓΗ ΚΑΤΑΣΤΗΜΑΤΟΣ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700),
              ),),
          Center(
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                  child: Divider(
                    color: Colors.white,
                    height: 50,
                  ),
                ),
                ),
                Text('•', style: TextStyle(color: Colors.white)),
                Expanded(child: Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ),
              ],
            ),
          ),
          _buildContests(context),
          Container(
            width: 250,
            height: 1,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () => EditJobPage.show(context),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/house.png',
                          height: 120, width: 190),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'ΝΕΟ ΚΑΤΑΣΤΗΜΑ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContests(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context , snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job ) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => EditJobPage.show(context, job: job),
            ),
          ),
        );
      },
    );
  }

}
