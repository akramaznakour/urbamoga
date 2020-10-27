class Actualite {
  String title;
  String content;
  String image;
  String date;
  String url;

  Actualite({this.title, this.content, this.image, this.date, this.url});

  Actualite.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['date'] = this.date;
    data['url'] = this.url;
    return data;
  }
}
