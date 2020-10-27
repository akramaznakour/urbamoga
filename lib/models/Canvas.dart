class Canvas {
  String id;
  List<String> labels;
  String title;
  String xAxesLabel;
  String yAxesLabel;

  List<Dataset> datasets;

  Canvas({this.id, this.labels, this.title, this.xAxesLabel, this.yAxesLabel});

  Canvas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    xAxesLabel = json['xAxesLabel'];
    yAxesLabel = json['yAxesLabel'];

    labels =
        List.from(json['labels']).map((labels) => labels.toString()).toList();

    datasets = List.from(json['datasets'])
        .map((dataset) => Dataset.fromJson(dataset))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['labels'] = this.labels;
    data['title'] = this.title;
    data['xAxesLabel'] = this.xAxesLabel;
    data['yAxesLabel'] = this.yAxesLabel;
    data['datasets'] = this.datasets.map((Dataset dataset) => dataset.toJson());
    return data;
  }
}

class Dataset {
  String label;
  String backgroundColor;
  List<int> data;

  Dataset({
    this.label,
    this.backgroundColor,
    this.data,
  });

  Dataset.fromJson(Map<String, dynamic> json) {
    print("Dataset before");
    label = json['label'];
    backgroundColor = json['backgroundColor'];
    data = List.from(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['backgroundColor'] = this.backgroundColor;
    data['data'] = this.data;
    return data;
  }
}
