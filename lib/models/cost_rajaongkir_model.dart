class CostRajaongkirModel {
  CostRajaongkirModel({
    this.code,
    this.name,
    this.costs,
  });

  String? code;
  String? name;
  List<CostRajaongkirModelCost>? costs;

  factory CostRajaongkirModel.fromJson(Map<String, dynamic> json) =>
      CostRajaongkirModel(
        code: json["code"],
        name: json["name"],
        costs: List<CostRajaongkirModelCost>.from(
            json["costs"].map((x) => CostRajaongkirModelCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs!.map((x) => x.toJson())),
      };
}

class CostRajaongkirModelCost {
  CostRajaongkirModelCost({
    this.service,
    this.description,
    this.cost,
  });

  String? service;
  String? description;
  List<CostCost>? cost;

  factory CostRajaongkirModelCost.fromJson(Map<String, dynamic> json) =>
      CostRajaongkirModelCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost!.map((x) => x.toJson())),
      };
}

class CostCost {
  CostCost({
    this.value,
    this.etd,
    this.note,
  });

  int? value;
  String? etd;
  String? note;

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
