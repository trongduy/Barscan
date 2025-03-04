class ProductModel{
  String? productId;
  int? quantity;

  ProductModel({ this.productId, this.quantity});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }

  @override
  String toString() {
    return '{"productId": "$productId", "quantity": "$quantity"}';
  }
}