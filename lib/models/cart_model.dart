import 'package:toko_app/models/product_model.dart';

class CartModel {
  int? id;
  ProductModel? product;
  int? quantity;

  CartModel({this.id, this.product, this.quantity});
}
