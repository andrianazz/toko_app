class ProvinceRajaongkirModel {
  String? provinceId;
  String? province;

  ProvinceRajaongkirModel({
    this.provinceId,
    this.province,
  });

  factory ProvinceRajaongkirModel.fromJson(Map<String, dynamic> json) =>
      ProvinceRajaongkirModel(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };
}
