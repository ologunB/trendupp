class PostModel {
  String? id;
  String? title;
  String? message;
  String? picture;
  String? type;
  String? createdAt;
  String? updatedAt;

  PostModel(
      {this.id,
      this.title,
      this.message,
      this.picture,
      this.type,
      this.createdAt,
      this.updatedAt});

  PostModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['brandName'];
    message = json['websiteUrl'];
    picture = json['picture'];
    type = json['about'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.title;
    data['websiteUrl'] = this.message;
    data['picture'] = this.picture;
    data['about'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
