class ItemModel {
  final String id;
  final String photo;
  final String photo2;
  final String photo3;
  final String desc;
  final String name;
  final String deliverytime;
  final int price;
  final String color;
  final String size;
  final int star;
  final String category;
  final int originalQuantity;
  final int originalPrice;
  final int remainQuantity;
  int? count;
  // final DateTime? created;

  ItemModel({
    required this.id,
    required this.photo,
    required this.photo2,
    required this.photo3,
    required this.name,
    required this.deliverytime,
    required this.price,
    required this.desc,
    required this.color,
    required this.size,
    required this.star,
    required this.category,
    required this.originalPrice,
    required this.originalQuantity,
    required this.remainQuantity,
    this.count = 0,
    // this.created,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json, id) => ItemModel(
        id: id,
        photo: json['photo'] as String,
        photo2: json['photo2'] as String,
        photo3: json['photo3'] as String,
        name: json['name'] as String,
        deliverytime: json['deliverytime'] as String,
        desc: json['desc'] as String,
        price: json['price'] as int,
        color: json['color'] as String,
        size: json['size'] as String,
        star: json['star'] as int,
        category: json['category'] as String,
        originalPrice: json['originalPrice'] as int,
        originalQuantity: json['originalQuantity'] as int,
        remainQuantity: json['remainQuantity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'photo2': photo2,
        'photo3': photo3,
        'name': name,
        'deliverytime': deliverytime,
        'price': price,
        'color': color,
        'size': size,
        'star': star,
        'category': category,
        'desc': desc,
        'originalPrice': originalPrice,
        'originalQuantity': originalQuantity,
        'remainQuantity': remainQuantity,
      };

  ItemModel copyWith({
    String? newPhoto,
    String? newPhoto2,
    String? newPhoto3,
    String? newDeliveryTime,
    String? newName,
    String? des,
    int? newPrice,
    String? newColor,
    String? newSize,
    int? newStar,
    String? newCategory,
    int? originalPrice,
    int? originalQuantity,
    int? remainQuantity,
    int? count,
  }) =>
      ItemModel(
        id: id,
        photo: newPhoto ?? photo,
        photo2: newPhoto2 ?? photo2,
        photo3: newPhoto3 ?? photo3,
        deliverytime: newDeliveryTime ?? deliverytime,
        name: newName ?? name,
        price: newPrice ?? price,
        desc: des ?? desc,
        color: newColor ?? color,
        size: newSize ?? size,
        star: newStar ?? star,
        category: newCategory ?? category,
        originalPrice: originalPrice ?? this.originalPrice,
        originalQuantity: originalQuantity ?? this.originalQuantity,
        remainQuantity: remainQuantity ?? this.remainQuantity,
        count: count ?? this.count,
      );
}
