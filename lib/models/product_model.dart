import 'package:toko_app/models/category_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? code;
  int? price;
  int? capital;
  String? description;
  String? imageUrl;
  int? stock;
  int? firstStock;
  DateTime? stockDate;
  List<String>? tag;
  Map<String, dynamic>? supplier;

  ProductModel({
    this.id,
    this.name,
    this.code,
    this.price,
    this.capital,
    this.description,
    this.imageUrl,
    this.stock,
    this.firstStock,
    this.stockDate,
    this.tag,
    this.supplier,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nama'];
    code = json['kode'];
    price = json['harga_jual'];
    capital = json['harga_modal'];
    description = json['deskripsi'];
    imageUrl = json['imageUrl'];
    stock = json['sisa_stok'];
    firstStock = json['stok_awal'];
    stockDate = json['stok_tanggal'];
    tag = json['tag'];
    supplier = json['supplier'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': name,
      'kode': code,
      'harga_jual': price,
      'harga_modal': capital,
      'deskripsi': description,
      'imageUrl': imageUrl,
      'sisa_stok': stock,
      'stok_awal': firstStock,
      'stok_tanggal': stockDate,
      'tag': tag,
      'supplier': supplier,
    };
  }
}

List<ProductModel> mockProduct = [
  ProductModel(
    name: 'Wortel Segar',
    code: 'WS-001',
    price: 14000,
    capital: 12000,
    description:
        'Wortel merupakan sayuran berwarna oranye yang banyak digemari, karena rasanya yang enak dan manfaat wortel yang melimpah. Wortel bisa dimakan mentah, direbus, atau digoreng, dibuat jus, atau campuran puding.',
    imageUrl:
        'https://ik.imagekit.io/10tn5i0v1n/article/f7868cd4c1339025ba7656df2175e9d4.jpeg',
    stock: 100,
    stockDate: DateTime.now(),
  ),
  ProductModel(
    name: 'Cabe Segar',
    code: 'CS-001',
    price: 35000,
    capital: 30000,
    description:
        'Cabai adalah buah dan tumbuhan anggota genus Capsicum. Buahnya dapat digolongkan sebagai sayuran maupun bumbu, tergantung bagaimana pemanfaatannya. Sebagai bumbu, buah cabai yang pedas sangat populer di Asia Tenggara sebagai penguat rasa makanan.',
    imageUrl: 'https://kbu-cdn.com/bc/wp-content/uploads/cabe-cabai.jpg',
    stock: 40,
    stockDate: DateTime.now(),
  ),
  ProductModel(
    name: 'Beras Belida Edisi Spesial',
    code: 'BB-001',
    price: 50000,
    capital: 45000,
    description:
        'Beras adalah bagian bulir padi (gabah) yang telah dipisah dari sekam. Sekam (Jawa merang) secara anatomi disebut palea (bagian yang ditutupi) dan lemma (bagian yang menutupi).',
    imageUrl:
        'https://media.suara.com/pictures/653x366/2014/10/24/o_1950dm43f1fr910u51bme1jkk9ibq.jpg',
    stock: 80,
    stockDate: DateTime.now(),
  ),
  ProductModel(
    name: 'Roti Lapis',
    code: 'RL-001',
    price: 4000,
    capital: 3000,
    description:
        'BRoti lapis atau roti isi (bahasa Inggris: sandwich), adalah makanan yang biasanya terdiri dari sayuran, keju atau daging yang diiris',
    imageUrl:
        'https://statik.tempo.co/data/2019/10/06/id_878322/878322_720.jpg',
    stock: 45,
    stockDate: DateTime.now(),
  ),
  ProductModel(
    name: 'Shampoo Unilever',
    code: 'SU-001',
    price: 4000,
    capital: 3500,
    description:
        'Sampo (bahasa Inggris: shampoo) adalah sejenis cairan, seperti sabun, yang berfungsi untuk meningkatkan tegangan permukaan kulit (umumnya kulit kepala) sehingga dapat meluruhkan kotoran (membersihkan).',
    imageUrl:
        'https://www.paulaschoice-eu.com/on/demandware.static/-/Sites-paulaschoice-catalog/default/dw4fa91958/images/5000-lifestyle.jpg',
    stock: 55,
    stockDate: DateTime.now(),
  ),
];
