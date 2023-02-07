class ListPostsRequestModel {
  int? count;
  int? lastId;
  int? index;

  ListPostsRequestModel({this.count, this.lastId, this.index});

  ListPostsRequestModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    lastId = json['last_id'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count.toString();
    data['last_id'] = this.lastId.toString();
    data['index'] = this.index.toString();
    return data;
  }
}

class ListVideosRequestModel {
  String? token;
  int? count;
  int? lastId;
  int? index;

  ListVideosRequestModel({this.token, this.count, this.lastId, this.index});

  ListVideosRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    count = json['count'];
    lastId = json['last_id'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['count'] = this.count.toString();
    data['last_id'] = this.lastId.toString();
    data['index'] = this.index.toString();
    return data;
  }
}

class ListInProfileRequestModel {
  String? targetId;
  String? token;
  int? count;
  int? lastId;
  int? index;

  ListInProfileRequestModel(
      {this.targetId, this.token, this.count, this.lastId, this.index});

  ListInProfileRequestModel.fromJson(Map<String, dynamic> json) {
    targetId = json['targetId'];
    token = json['token'];
    count = json['count'];
    lastId = json['last_id'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['targetId'] = this.targetId;
    data['token'] = this.token;
    data['count'] = this.count.toString();
    data['last_id'] = this.lastId.toString();
    data['index'] = this.index.toString();
    return data;
  }
}
