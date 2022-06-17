import 'package:barcode_scander/network/response_model.dart';

class ConfigModel{
  int? configDetailId;
  int? configId;
  String? configName;
  String? descriptionName;

  ConfigModel({this.configDetailId, this.configId, this.configName,
      this.descriptionName});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    configDetailId = json['ConfigDetailId'];
    configId = json['ConfigId'];
    configName = json['ConfigName'];
    descriptionName = json['DescriptionName'];
  }
  List<ConfigModel> listFromJson(ResponseModel parserModel){
    List<ConfigModel> list =<ConfigModel>[];
    if (parserModel.response != null) {
      parserModel.response.forEach((v) {
        list.add(ConfigModel.fromJson(v));
      });
    }
    return list;
  }

  @override
  String toString() {
    return 'ConfigModel{configDetailId: $configDetailId, configId: $configId, configName: $configName, descriptionName: $descriptionName}';
  }
}