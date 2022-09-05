// To parse this JSON data, do
//
//     final videos = videosFromJson(jsonString);

import 'dart:convert';

Videos videosFromJson(dynamic str) => Videos.fromJson(str);

String videosToJson(Videos data) => json.encode(data.toJson());

class Videos {
  Videos({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<DatumVideo> data;
  String firstPageUrl;
  dynamic from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  dynamic to;
  int total;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        currentPage: json["current_page"],
        data: List<DatumVideo>.from(json["data"].map((x) => DatumVideo.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DatumVideo {
  DatumVideo({
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
  dynamic isFavorite;
  Category category;
  List<Category> tags;

  factory DatumVideo.fromJson(Map<String, dynamic> json) => DatumVideo(
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

class Pivot {
  Pivot({
    required this.taggableId,
    required this.tagId,
    required this.taggableType,
  });

  int taggableId;
  int tagId;
  String taggableType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        taggableId: json["taggable_id"],
        tagId: json["tag_id"],
        taggableType: json["taggable_type"],
      );

  Map<String, dynamic> toJson() => {
        "taggable_id": taggableId,
        "tag_id": tagId,
        "taggable_type": taggableType,
      };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  dynamic url;
  dynamic label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
