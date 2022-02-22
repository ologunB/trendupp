class PayoutModel {
  String? id;
  String? title;
  String? message;
  String? picture;
  String? type;
  String? amount;
  String? createdAt;
  String? updatedAt;

  PayoutModel(
      {this.id,
      this.title,
      this.message,
      this.picture,
      this.type,
      this.createdAt,this.amount,
      this.updatedAt});

  PayoutModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['brandName'];
    message = json['websiteUrl'];
    picture = json['picture'];
    amount = json['amount'];
    type = json['about'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.title;
    data['websiteUrl'] = this.message;
    data['amount'] = this.amount;
    data['picture'] = this.picture;
    data['about'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
