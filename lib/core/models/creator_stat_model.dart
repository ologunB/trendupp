class CreatorStat {
  int? posts;
  List<Supporters>? supporters;
  int? amount;
  int? supportersNumber;

  CreatorStat(
      {this.posts, this.supporters, this.amount, this.supportersNumber});

  CreatorStat.fromJson(dynamic json) {
    posts = json['posts'];
    if (json['supporters'] != null) {
      supporters = <Supporters>[];
      json['supporters'].forEach((v) {
        supporters!.add(Supporters.fromJson(v));
      });
    }
    amount = json['amount'];
    supportersNumber = json['supporters_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['posts'] = this.posts;
    if (this.supporters != null) {
      data['supporters'] = this.supporters!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['supporters_number'] = this.supportersNumber;
    return data;
  }
}

class Supporters {
  int? id;
  String? reference;
  String? amount;
  String? paymentPlan;
  String? email;
  String? firstName;
  String? lastName;
  String? message;
  int? creatorId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Supporters(
      {this.id,
      this.reference,
      this.amount,
      this.paymentPlan,
      this.email,
      this.firstName,
      this.lastName,
      this.message,
      this.creatorId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Supporters.fromJson(dynamic json) {
    id = json['id'];
    reference = json['reference'];
    amount = json['amount'];
    paymentPlan = json['payment_plan'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    message = json['message'];
    creatorId = json['creatorId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['amount'] = this.amount;
    data['payment_plan'] = this.paymentPlan;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['message'] = this.message;
    data['creatorId'] = this.creatorId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
