// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  DetailsModel({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.slug,
    required this.description,
    required this.thumb,
    required this.video,
    required this.artistName,
    required this.relaseYear,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    required this.category,
    required this.tags,
  });

  int id;
  int categoryId;
  String title;
  String slug;
  String description;
  String thumb;
  String video;
  String artistName;
  String relaseYear;
  String rating;
  DateTime createdAt;
  DateTime updatedAt;
  bool isFavorite;
  Category category;
  List<Category> tags;

  set setFav(bool fav) {
    isFavorite = !isFavorite;
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        thumb: json["thumb"],
        video: json["video"],
        artistName: json["artist_name"],
        relaseYear: json["relase_year"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavorite: json["isFavorite"],
        category: Category.fromJson(json["category"]),
        tags:
            List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "slug": slug,
        "description": description,
        "thumb": thumb,
        "video": video,
        "artist_name": artistName,
        "relase_year": relaseYear,
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "isFavorite": isFavorite,
        "category": category.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class Category {
  Category({
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
  dynamic parentId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
