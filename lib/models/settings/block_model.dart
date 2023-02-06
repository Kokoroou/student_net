import 'dart:convert';

class BlockRequestModel{
  String? token;
  String? index;
  String? count;

  BlockRequestModel({this.token, this.index, this.count});

  BlockRequestModel.fromJson(Map<String, dynamic> json){
    token = json['token'];
    index = json['index'];
    count = json['count'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data= new Map<String, dynamic>();
    data['token'] = this.token;
    data["index"] = this.index;
    data['count'] = this.count;

    return data;
  }
}


class BlockResponseModel{
  String? code; 
  String? message;
  Data?data;

  BlockResponseModel({this.code, this.message, this.data});

  BlockResponseModel.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data= json['data'] != null? new Data.fromJson(json['data']) : null;
  }


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data= new Map<String, dynamic>();

    // data['code'] = this.code;
    // data['message'] = this.message;
    // if (this.data != null){
    //   data['data'] = this.data!.toJson();
    // }

    return data;
  }

  List? getListBlocks(){
    if (data == null){
      return [] ;
    }
    else{
      return data!.ls_blocks;
    }
  }


}

class Data{
  List? ls_blocks = [];

  Data.fromJson(List? list_json){
    for (var each in list_json!){
      ls_blocks!.add(Friends.fromJson(each));
    }
  }


}


class Friends{
  
  String? id; 
  String? username;
  String? avatar; 

  
  Friends({this.id, this.username, this.avatar});
  Friends.fromJson(Map<String, dynamic> json){
      // if(each != null){
        id = json['id'];
        username= json['username'];
        avatar = json['avatar'];
      // }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data= new Map<String, dynamic> ();
    // data['id'] = this.id; 

    return data;
  }
}

