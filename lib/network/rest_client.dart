import 'dart:io';

import 'package:barcode_scander/helper/singleton_storage.dart';
import 'package:barcode_scander/models/config_model.dart';
import 'package:barcode_scander/network/network.dart';
import 'package:barcode_scander/network/request/post_model.dart';
import 'package:barcode_scander/network/response_model.dart';
import 'package:barcode_scander/screen/general_screen.dart';
import 'package:dio/dio.dart';

class RestClient{
 //final String url ='http://113.161.222.192:8686';
  String url ='';
  late Dio dio;
 late Network network;
  GeneralScreen? screen;
  RestClient(GeneralScreen _screen,String path) {
    screen =_screen;
    url =path;
    dio =  Dio();
    dio.options.baseUrl=url;
    dio.interceptors.add(AppInterceptors(screen));
    network =  Network(dio,baseUrl: url);
  }
  Future<bool> postFile(DataPost postModel,String nameFile,String configName) async {

    bool success =false;
    screen!.showLoading(true);
    try {
      ResponseModel response = await network.postFile(postModel, nameFile,configName);
      if(response!=null){
        if(response.status==1){
          success =true;
        }
      }

    } on DioError catch(dioError){
      screen!.showLoading(false);
      screen!.showMessage('Lỗi kết nối');
    }
    screen!.showLoading(false);
    return success;
  }

  Future<ResponseModel?> deleteAllFileInFolder(String foldername) async {
    ResponseModel? response;
    screen!.showLoading(true);
    try {
      var data = await network.deleteAllFileInFolder(foldername);
      response =data;
    } on DioError catch(dioError){
      screen!.showLoading(false);
      screen!.showMessage('Lỗi kết nối');
    }
    screen!.showLoading(false);
    return response;
  }

  Future<ResponseModel?> checkPassword(String password) async {
    ResponseModel? response;
    screen!.showLoading(true);
    try {
      var data = await network.checkPassword(password);
      response =data;

    } on DioError catch(dioError){
      screen!.showLoading(false);
      screen!.showMessage('Lỗi kết nối');
    }

    screen!.showLoading(false);
    return response;
  }
  Future<List<ConfigModel>> getConfig(String keyConfig) async {
    screen?.showLoading(true);
    List<ConfigModel> listConfig =<ConfigModel>[];
    try {
      var data = await network.getConfigDetail(keyConfig);
      if(data.response!=null){
        listConfig =ConfigModel().listFromJson(data);
      }
    } on DioError catch(dioError){
      screen?.showLoading(false);
      screen!.showMessage('Lỗi kết nối');
    }
    screen!.showLoading(false);
    return listConfig;
  }
}

class AppInterceptors extends InterceptorsWrapper {
  GeneralScreen? generalScreen;
  // bool? token;
   AppInterceptors(this.generalScreen);
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //  await SingletonStorage.getInstance();
    //var token = await SingletonStorage.getDeviceToken();// todo add header
    //    token??'';
    String token='';
    // print('token $token');

    Map<String, dynamic> requestHeaders = {
      'contentType': 'application/json',// todo contentType is Error booking
      'Authorization': token,
      'Language': 'vi'
    };
    options.headers =requestHeaders;
    return super.onRequest(options, handler);
  }
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // print('response ${response.data.toString()}');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    // var url = err.request.uri;
    print("************************************************");
    print(err);
    //generalScreen!.showMessage('Lỗi kết  nối:');
    super.onError(err, handler);
  }
}