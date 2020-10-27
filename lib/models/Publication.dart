class Publication {
  String title;
  String content;
  String date;
  String url;

  Publication({this.title, this.content, this.date, this.url});

  Publication.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['url'] = this.url;
    return data;
  }
}
