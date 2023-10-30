import 'dart:convert';

class Product {
  Product({
    required this.list
  });

  List<ProductList> list;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    list: List<ProductList>.from(json["Listado"].map((x) => ProductList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Listado": List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class ProductList {
  ProductList({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productState      
  });

  int productId;
  String productName;
  int productPrice;
  String productImage;
  String productState;

  factory ProductList.fromJson(String str) => ProductList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductList.fromMap(Map<String, dynamic> json) => ProductList(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    productState: json["product_state"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
    "product_state": productState
  };

  ProductList copy() => ProductList(
      productId: productId,
      productName: productName,
      productPrice: productPrice,
      productImage: productImage,
      productState: productState
  );
}