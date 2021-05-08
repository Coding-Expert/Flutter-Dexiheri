
import 'package:dexiheri/app/home/files/Notification/notification_page.dart';
import 'package:dexiheri/app/home/files/beach/beach_result.dart';
import 'package:dexiheri/app/home/files/building/building_result.dart';
import 'package:dexiheri/app/home/files/certification/certification_page.dart';
import 'package:dexiheri/app/home/files/corporate/corporate_page.dart';
import 'package:dexiheri/app/home/files/courts/courts_page.dart';
import 'package:dexiheri/app/home/files/detail_search.dart';
import 'package:dexiheri/app/home/files/diagram/diagram_page.dart';
import 'package:dexiheri/app/home/files/estate/estate_page.dart';
import 'package:dexiheri/app/home/files/floating/floating_result.dart';
import 'package:dexiheri/app/home/files/lease/lease_result.dart';
import 'package:dexiheri/app/home/files/music/music_page.dart';
import 'package:dexiheri/app/home/files/occupation/occupation_result.dart';
import 'package:dexiheri/app/home/files/protection/protection_page.dart';
import 'package:dexiheri/app/home/files/trademark/trademark_result.dart';
import 'package:dexiheri/app/home/files/user/user_result.dart';
import 'package:dexiheri/app/models/document.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {

  String title;
  int index;
  List<Document> document_list;
  Job job;

  CategoryWidget ({
    Key key,
    this.title,
    this.index,
    this.document_list,
    this.job
  }) : super(key: key);
  CategoryWidgetState createState ()=> CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if(widget.title == "ΕΓΓΡΑΦΑ ΑΠΟ ΥΠΗΡΕΣΙΕΣ"){        //15
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSearchPage(
                category_number: widget.index + 1,
                category_title: widget.title,
                document_list: widget.document_list,
                job: widget.job
              )));
            }
            if(widget.title == "ΘΕΜΑΤΑ ΜΟΥΣΙΚΗΣ"){        //2
              Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΑΔΕΙΑ ΛΕΙΤΟΥΡΓΙΑΣ/ ΓΝΩΣΤΟΠΟΙΗΣΗ"){    //1
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΑΔΕΙΑ ΚΑΤΑΛΗΨΗΣ ΚΟΙΝΟΧΡΗΣΤΟΥ ΧΩΡΟΥ ΤΡΑΠΕΖΟΚΑΘΙΣΜΑΤΩΝ"){   //3
              Navigator.push(context, MaterialPageRoute(builder: (context) => OccupationResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }
            if(widget.title == "ΠΙΣΤΟΠΟΙΗΤΙΚΑ ΥΓΕΙΑΣ / ΑΔΕΙΕΣ ΕΡΓΑΣΙΑΣ ΕΡΓΑΖΟΜΕΝΩΝ / ΠΙΝΑΚΑΣ ΠΡΟΣΩΠΙΚΟΥ"){      //4
              Navigator.push(context, MaterialPageRoute(builder: (context) => CertificationPage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΠΥΡΟΠΡΟΣΤΑΣΙΑ"){    //5
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProtectionPage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΚΑΤΟΨΗ ΥΓΕΙΟΝΟΜΙΚΟΥ - ΔΙΑΓΡΑΜΜΑ ΡΟΗΣ"){     //6
              Navigator.push(context, MaterialPageRoute(builder: (context) => DiagramPage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΕΤΑΙΡΙΚΟ"){       //7
              Navigator.push(context, MaterialPageRoute(builder: (context) => CorporatePage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΜΙΣΘΩΤΗΡΙΟ"){   //8
              Navigator.push(context, MaterialPageRoute(builder: (context) => LeaseResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }
            if(widget.title == "ΠΟΛΕΟΔΟΜΙΚΑ ΑΚΙΝΗΤΟΥ"){       //9
              Navigator.push(context, MaterialPageRoute(builder: (context) => EstatePage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΚΑΝΟΝΙΣΜΟΣ ΠΟΛΥΚΑΤΟΙΚΙΑΣ"){   //10
              Navigator.push(context, MaterialPageRoute(builder: (context) => BuildingResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }
            if(widget.title == "ΑΔΕΙΑ/ΜΙΣΘΩΣΗ ΠΑΡΑΛΙΑΣ ΑΙΓΙΑΛΟΥ"){   //11
              Navigator.push(context, MaterialPageRoute(builder: (context) => BeachResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }
            if(widget.title == "ΑΔΕΙΑ ΠΛΩΤΗΣ ΕΞΕΔΡΑΣ"){   //12
              Navigator.push(context, MaterialPageRoute(builder: (context) => FloatingResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }
            if(widget.title == "ΕΜΠΟΡΙΚΟ ΣΗΜΑ"){   //13
              Navigator.push(context, MaterialPageRoute(builder: (context) => TradeMarkResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }
            if(widget.title == "ΔΙΚΑΣΤΗΡΙΑ"){       //14
              Navigator.push(context, MaterialPageRoute(builder: (context) => CourtsPage(
                title: widget.title,
                category_number: widget.index + 1,
                job: widget.job
              )));
            }
            if(widget.title == "ΠΡΟΣΩΠΙΚΟΣ ΦΑΚΕΛΟΣ ΧΡΗΣΤΗ"){       //16
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserResultPage(
                category: widget.title,
                category2: null,
                category3: null,
                job: widget.job
              )));
            }

          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  (widget.index + 1).toString() + ". " + widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  maxLines: 1,
                )
              ),
              Icon(Icons.arrow_right)
            ],
          ),
        ),
        Container(
          height: 1,
          color: Colors.black,
        ),
        SizedBox(height: 10),
      ]
    );
  }

}