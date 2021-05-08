
class Document {

  String title;
  String shop;
  String category;
  String date;
  String image;
  String id;
  String category2;
  String category3;
  String expire_date;
  

  Document({
    this.title,
    this.shop,
    this.category,
    this.date,
    this.image,
    this.id,
    this.category2,
    this.category3,
    this.expire_date
  });

  factory Document.fromMap(Map<String, dynamic> json) {
    if(json == null){
      return null;
    }
    return Document(
      title: json["title"],
      shop: json["shop"],
      category: json["category"],
      date: json["date"],
      image: json["image"],
      
    );
  }

}