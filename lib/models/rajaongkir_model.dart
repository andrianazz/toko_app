class RajaOngkirModel {
  String? city_id;
  String? province_id;
  String? province;
  String? type;
  String? city_name;
  String? postal_code;

  RajaOngkirModel({
    this.city_id,
    this.province_id,
    this.province,
    this.type,
    this.city_name,
    this.postal_code,
  });

  RajaOngkirModel.fromJson(Map<String, dynamic> json) {
    city_id = json['city_id'];
    province_id = json['province_id'];
    province = json['province'];
    type = json['type'];
    city_name = json['city_name'];
    postal_code = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': city_id,
      'province_id': province_id,
      'province': province,
      'type': type,
      'city_name': city_name,
      'postal_code': postal_code,
    };
  }
}
