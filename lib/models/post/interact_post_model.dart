class AddPostRequestModel {
  String? token;
  String? described;
  String? status;

  AddPostRequestModel({this.token, this.described, this.status});

  AddPostRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    described = json['described'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['described'] = this.described;
    data['status'] = this.status;
    return data;
  }
}

class GetPostRequestModel {
  String? token;
  String? id;

  GetPostRequestModel({this.token, this.id});

  GetPostRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    return data;
  }
}

class EditPostRequestModel {
  String? token;
  String? id;
  String? described;
  String? status;
  String? imageDel;

  EditPostRequestModel(
      {this.token, this.id, this.described, this.status, this.imageDel});

  EditPostRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    described = json['described'];
    status = json['status'];
    imageDel = json['image_del'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['described'] = this.described;
    data['status'] = this.status;
    data['image_del'] = this.imageDel;
    return data;
  }
}

class DeletePostRequestModel {
  String? token;
  String? id;

  DeletePostRequestModel({this.token, this.id});

  DeletePostRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    return data;
  }
}
