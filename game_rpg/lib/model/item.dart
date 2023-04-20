class Item {
  late final int id;
  late final String image;
  late final String itemName;
  late final String desc;
  late int quantity;
  late final int weight;

  Item.empty();

  Item({
    required this.id,
    required this.image,
    required this.itemName,
    required this.desc,
    required this.quantity,
    required this.weight,
  });

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(
      id: json['id'], 
      image: json['image'], 
      itemName: json['item_name'], 
      desc: json['desc'],
      quantity: json['quantity'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'image': image,
    'item_name': itemName,
    'desc': desc,
    'quantity': quantity,
    'weight': weight,
  };
}