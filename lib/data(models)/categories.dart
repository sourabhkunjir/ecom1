class CategoryModal {
  String? slug;
  String? name;
  String? url;
  
  CategoryModal({this.slug, this.name, this.url});

  CategoryModal.fromJson(Map<String, dynamic> json) {
    slug = json["slug"];
    name = json["name"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["slug"] = slug;
    data["name"] = name;
    data["url"] = url;
    return data;
  }
}
