class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";
  String? instruction;
  String? id;
  String? image;
  String? name;
  int quantity = 1;
  double? cost;
  String? productId;
  double? price;

  CartItemModel({
    this.productId,
    this.instruction,
    this.id,
    this.image,
    this.name,
    required this.quantity,
    this.cost,
  });

  CartItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    quantity = data[QUANTITY];
    cost = data[COST].toDouble();
    productId = data[PRODUCT_ID];
    price = data[PRICE].toDouble();
    instruction = data['instruction'];
  }

  Map toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: price!.toDouble() * quantity,
        PRICE: price,
        'instruction': instruction
      };
}
