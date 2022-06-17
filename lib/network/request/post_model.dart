class PostModel{
  String? productId;
  String? serial;

  PostModel({this.productId, this.serial});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ProductId'] = productId;
    data['Serial'] = serial;
    return data;
  }

  @override
  String toString() {
    return '{productId: $productId, serial: $serial}';
  }
}
class DataPost{
  List<PostModel>?dataPost;

  DataPost({this.dataPost});
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = dataPost;
    return data;
  }

  @override
  String toString() {
    return '{dataPost: $dataPost}';
  }
}