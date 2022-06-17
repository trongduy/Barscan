import 'package:barcode_scander/network/request/post_model.dart';
import 'package:barcode_scander/network/response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'network.g.dart';
@RestApi(baseUrl: '')
abstract class Network{
  factory Network(Dio dio, {String? baseUrl}) {
    Map<String, dynamic> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Language': 'vi'
    };
    // dio.options = BaseOptions(
    //  receiveTimeout: 10000,
    //  connectTimeout: 10000,
    //   contentType: 'application/json',
    //   headers: requestHeaders,
    // );

    dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));// // todo: this is log body every request and response
    //final client = Network(dio, baseUrl: "your base url");
    return _Network(dio, baseUrl: baseUrl);
  }
  @POST('/api/Menu/PostUpLoadFile')
  Future<ResponseModel> postFile(@Body()DataPost post,@Query('FileName') String fileName,@Query('ConfigName') String configName);//

  @POST('/api/Menu/CheckPassWordConfigUrl')
  Future<ResponseModel> checkPassword(@Query('Password') String password);

  @GET('/api/Menu/GetConfigDetail')
  Future<ResponseModel> getConfigDetail();

  @GET('/api/Sound/GetSoundError')
  Future<ResponseModel> getSoundError();
}
