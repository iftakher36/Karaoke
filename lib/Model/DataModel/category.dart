import 'dart:convert';
// To parse this JSON data, do
//
//     final catagories = catagoriesFromJson(jsonString);

Catagories catagoriesFromJson(String str) =>
    Catagories.fromJson(json.decode(str));

String catagoriesToJson(Catagories data) => json.encode(data.toJson());

class Catagories {
  Catagories({
    required this.message,
    required this.data,
  });

  String message;
  List<Datums> data;

  factory Catagories.fromJson(Map<String, dynamic> json) => Catagories(
        message: json["message"],
        data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datums {
  Datums({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String slug;
  String description;
  bool _isSelected = false;
  dynamic parentId;
  dynamic createdAt;
  dynamic updatedAt;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  factory Datums.fromJson(Map<String, dynamic> json) => Datums(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        parentId: json["parent_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "parent_id": parentId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
