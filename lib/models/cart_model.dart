class CartModel {
  CartModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  dynamic message;
  CartData data;

   CartModel.fromJson(Map<String, dynamic> json){
     status= json["status"];
     message= json["message"];
     data= CartData.fromJson(json["data"]);
   }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class CartData {
  CartData({
    this.cartItems,
    this.subTotal,
    this.total,
  });

  List<CartItem> cartItems;
  int subTotal;
  int total;

   CartData.fromJson(Map<String, dynamic> json){
     cartItems= List<CartItem>.from(json["cart_items"].map((x) => CartItem.fromJson(x)));
     subTotal= json["sub_total"];
     total= json["total"];
   }



  Map<String, dynamic> toJson() => {
    "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
    "sub_total": subTotal,
    "total": total,
  };
}

class CartItem {
  CartItem({
    this.id,
    this.quantity,
    this.product,
  });

  int id;
  int quantity;
  Product product;

   CartItem.fromJson(Map<String, dynamic> json) {
     id= json["id"];
     quantity= json["quantity"];
     product= Product.fromJson(json["product"]);
   }

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "product": product.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

   Product.fromJson(Map<String, dynamic> json){
     id= json["id"];
     price= json["price"];
     oldPrice= json["old_price"];
     discount= json["discount"];
     image= json["image"];
     name= json["name"];
     description= json["description"];
     images= List<String>.from(json["images"].map((x) => x));
     inFavorites= json["in_favorites"];
     inCart= json["in_cart"];
   }

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
    "name": name,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "in_favorites": inFavorites,
    "in_cart": inCart,
  };
}
