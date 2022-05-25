import 'package:toko_app/models/product_model.dart';

enum Status { gagal, proses, berhasil }

class HistoryModel {
  int? id;
  String? imageUrl;
  int? item;
  DateTime? time;
  int? total;
  Status? status;

  HistoryModel(
      {this.id, this.imageUrl, this.item, this.time, this.total, this.status});
}

List<HistoryModel> mockHistory = [
  HistoryModel(
      id: 1,
      imageUrl:
          'https://ik.imagekit.io/10tn5i0v1n/article/f7868cd4c1339025ba7656df2175e9d4.jpeg',
      item: 3,
      time: DateTime.now(),
      total: 13000,
      status: Status.berhasil),
  HistoryModel(
      id: 2,
      imageUrl:
          'https://statik.tempo.co/data/2019/10/06/id_878322/878322_720.jpg',
      item: 4,
      time: DateTime.now(),
      total: 20000,
      status: Status.proses),
  HistoryModel(
      id: 3,
      imageUrl:
          'https://www.paulaschoice-eu.com/on/demandware.static/-/Sites-paulaschoice-catalog/default/dw4fa91958/images/5000-lifestyle.jpg',
      item: 2,
      time: DateTime.now(),
      total: 20000,
      status: Status.gagal),
];
