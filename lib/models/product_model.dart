import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    String? name;
    String? description;
    int? price;

    ProductModel({
        this.name,
        this.description,
        this.price,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        description: json["description"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
    };
}
