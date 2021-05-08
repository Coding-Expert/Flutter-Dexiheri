

class Event {

  String id;
  String date;
  String title;
  String description;
  String service;
  String courts_date;
  String license_date;
  String category;
  String image;

  Event({
    this.id,
    this.date,
    this.title,
    this.description,
    this.service,
    this.courts_date,
    this.license_date,
    this.category,
    this.image
  });

  factory Event.fromMap(Map<String, dynamic> json) {
    if(json == null){
      return null;
    }
    return Event(
      id: json["id"],
      date: json["date"],
      title: json["title"],
      description: json["description"],
      service: json["service"],
      courts_date: json["courts_date"],
      license_date: json["license_date"],
      category: json["category"],
      image: json["image"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "title" : title,
      "description" : description,
      "service" : service,
      "courts_date" : courts_date,
      "license_date" : license_date,
      "category" : category,
      "image" : image
    };
  }
}