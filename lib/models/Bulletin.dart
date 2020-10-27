class Bulletin {

  String title;
  String content;
  String attachment;
  String date;
  String url;

  Bulletin({this.title, this.content, this.attachment, this.date, this.url});

  Bulletin.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    attachment = json['attachment'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['attachment'] = this.attachment;
    data['date'] = this.date;
    data['url'] = this.url;
    return data;
  }
}
