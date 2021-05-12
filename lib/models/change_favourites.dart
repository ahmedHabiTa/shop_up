class ChangeFavouriteModel {
  ChangeFavouriteModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  FavouriteData data;

  factory ChangeFavouriteModel.fromJson(Map<String, dynamic> json) => ChangeFavouriteModel(
    status: json["status"],
    message: json["message"],
    data: FavouriteData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class FavouriteData{
  FavouriteData({
    this.id,
    this.product,
  });

  int id;
  FavouriteProduct product;

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    id: json["id"],
    product: FavouriteProduct.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
  };
}

class FavouriteProduct {
  FavouriteProduct({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
  });

  int id;
  int price;
  int oldPrice;
  int discount;
  String image;

  factory FavouriteProduct.fromJson(Map<String, dynamic> json) => FavouriteProduct (
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
  };
}
