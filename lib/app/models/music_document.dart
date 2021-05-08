

class MusicDocument {

  String title;
  String shop;
  String subcategory1;
  String subcategory2;
  String image;
  String id;
  String date;

  MusicDocument({
    this.title,
    this.shop,
    this.subcategory1,
    this.subcategory2,
    this.image,
    this.id,
    this.date
  });

  factory MusicDocument.fromMap(Map<String, dynamic> json) {
    if(json == null){
      return null;
    }
    return MusicDocument(
      title: json["title"],
      shop: json["shop"],
      subcategory1: json["subcategory1"],
      subcategory2: json["subcategory2"],
      image: json["url"],
      id: json["id"],
      date: json["date"]
    );
  }

}