class BarCodeModel{
  int? stt;
  String? customerCode;
  String? serial;

  BarCodeModel({this.stt, this.customerCode, this.serial});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['stt'] = stt;
    data['customerCode'] = customerCode;
    data['serial'] = serial;
    return data;
  }

  @override
  String toString() {
    return '{"stt": "$stt", "customerCode": "$customerCode", "serial": "$serial"}';
  }
}