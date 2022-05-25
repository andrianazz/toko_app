import 'package:toko_app/models/product_model.dart';

class CartModel {
  int? id;
  ProductModel? product;
  int? quantity;

  CartModel({this.id, this.product, this.quantity});
}

List<CartModel> mockCart = [
  CartModel(
    id: 1,
    product: mockProduct[0],
    quantity: 1,
  ),
  CartModel(
    id: 2,
    product: mockProduct[1],
    quantity: 2,
  ),
];
