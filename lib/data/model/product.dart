class Product {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? description;
  int? discountPrice;
  int? price;
  String? popularity;
  String? name;
  int? quantity;
  String? categoryId;
  int? finalPrice;
  num? percent;

  Product(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.description,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.categoryId,
  ) {
    finalPrice = price! - discountPrice!;
    percent = ((price! - finalPrice!) / price!) * 100;
  }

  factory Product.fromMapJson(Map<String, dynamic> jsonObject) {
    return Product(
      jsonObject['id'],
      jsonObject['collectionId'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['description'],
      jsonObject['discount_price'],
      jsonObject['price'],
      jsonObject['popularity'],
      jsonObject['name'],
      jsonObject['quantity'],
      jsonObject['category'],
    );
  }
}
