import 'dart:convert';

class DelSearchRequestModel{
  String? token;
  String? all;
  String? search_id; 

  DelSearchRequestModel({this.token, this.all, this.search_id});
  
  DelSearchRequestModel.fromJson(Map<String, dynamic> json){
    token = json['token'];
    all = json['all'];
    search_id = json['search_id'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data= new Map<String, dynamic>();

    data['token'] = this.token;
    data['all'] = this.all;
    data['search_id'] =this.search_id;

    return data;
  }
}