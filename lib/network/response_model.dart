
import '../helper/utils.dart';

class ResponseModel {
  int? status;
  String? message;
  dynamic response;

  ResponseModel({this.status, this.message, this.response});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if(json['message']!=null){
      if(Utils.isNotEmpty(json['message'])??true){
        message = json['message'];
      }
    }
    if(json['response']!=null){
      if(Utils.isNotEmpty(json['response'].toString())??true){
        response = json['response'];
      }
    }
    //print('response $response');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['response'] = response;
    return data;
  }

  @override
  String toString() {
    return 'ResponseModel{status: $status, message: $message, response: $response}';
  }
}