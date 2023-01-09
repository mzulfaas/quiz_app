class TopicsModel {
  String? topicsName;
  int? topicsId;

  TopicsModel({this.topicsName, this.topicsId});

  TopicsModel.fromJson(Map<String, dynamic> json) {
    topicsName = json['topicsName'];
    topicsId = json['topicsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicsName'] = this.topicsName;
    data['topicsId'] = this.topicsId;
    return data;
  }
}
