
// import 'package:dexiheri/app/home/files/detail_document.dart';
import 'package:dexiheri/app/home/files/service/service_page.dart';
import 'package:dexiheri/app/models/document.dart';
import 'package:dexiheri/app/models/job.dart';
import 'package:dexiheri/app/module/module.dart';
import 'package:flutter/material.dart';

class DetailCategoryWidget extends StatefulWidget {

  int index;
  String category2;
  String category;
  Job job;

  DetailCategoryWidget({
     Key key,
     this.index,
     this.category2,
     this.category,
     this.job
  }) : super(key: key);
  DetailCategoryWidgetState createState ()=> DetailCategoryWidgetState();
}

class DetailCategoryWidgetState extends State<DetailCategoryWidget> {

  List<Document> sub_doc_list = [];
  bool document_loading = true;

  @override
  void initState() {
    super.initState();
    // getSubDocumentList();
  }
  // void getSubDocumentList() {
  //   if(widget.document_list.length > 0){
  //     sub_doc_list = [];
  //     for(int i = 0; i < widget.document_list.length; i++) {
  //       if(widget.document_list[i].shop == widget.shop_id && widget.document_list[i].category == widget.document_category){
  //         sub_doc_list.add(widget.document_list[i]);
  //       }
  //     }
  //   }
  // }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceResultPage(
              category: widget.category,
              category2: widget.category2,
              category3: null,
              job: widget.job
            )));
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "15. " + widget.index.toString() + " " + widget.category2,
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

  @override
  void didUpdateWidget(DetailCategoryWidget oldWidget) {
    // getSubDocumentList();
    setState(() {
      
    });
    super.didUpdateWidget(oldWidget);
  }
}