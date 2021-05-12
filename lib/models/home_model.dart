class HomeModel {
  bool status;

  Data data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];

    data = Data.fromJson(json["data"]);
  }
}

class Data {
  List<ProductModel> products;

  Data.fromJson(Map<String, dynamic> json) {
    products = List<ProductModel>.from(
        json["products"].map((x) => ProductModel.fromJson(x)));
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;

  bool inFavorites;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"] == null ? null : json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount == null ? null : discount,
        "image": image,
        "name": name,
        "in_favorites": inFavorites,
        "in_cart": inCart,
      };
}
