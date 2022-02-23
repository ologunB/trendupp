import 'package:mms_app/core/models/user_model.dart';

class FanPaymentHistoryModel {
  List<FanHistoryModel>? history;
  UserData? user;

  FanPaymentHistoryModel({this.history, this.user});

  FanPaymentHistoryModel.fromJson(dynamic json) {
    if (json['history'] != null) {
      history = <FanHistoryModel>[];
      json['history'].forEach((v) {
        history!.add(new FanHistoryModel.fromJson(v));
      });
    }
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class FanHistoryModel {
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

  FanHistoryModel(
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

  FanHistoryModel.fromJson(dynamic json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
