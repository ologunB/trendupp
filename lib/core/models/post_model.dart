import 'package:mms_app/core/models/user_model.dart';

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
  String? amount;
  String? paymentPlan;
  String? createdAt;
  String? updatedAt;
  UserData? user;

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
    this.user,this.paymentPlan, this.amount,
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
    amount = json['amount'];
    paymentPlan = json['payment_plan'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['image'] = this.image;
    data['about'] = this.postType;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userImage'] = this.userImage;
    data['payment_plan'] = this.paymentPlan;
    data['amount'] = this.amount;
    data['youtube'] = this.youtube;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
