class PostModel {
  int? id;
  String? title;
  String? message;
  String? image;
  String? postType;
  String? youtube;
  int? userId;
  String? userName;
  String? userImage;
  String? createdAt;
  String? updatedAt;

  PostModel({
    this.id,
    this.title,
    this.message,
    this.image,
    this.postType,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.youtube,
    this.userName,
    this.userImage,
  });

  PostModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    postType = json['postType'];
    youtube = json['youtube'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['image'] = this.image;
    data['about'] = this.postType;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['youtube'] = this.youtube;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
