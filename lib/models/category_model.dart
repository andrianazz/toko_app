class CategoryModel {
  String? code;
  String? name;
  String? imageUrl;

  CategoryModel({
    this.code,
    this.name,
    this.imageUrl,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }
}
