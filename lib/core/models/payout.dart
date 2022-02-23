class PayoutModel {
  int? id;
  String? accountBank;
  String? accountNumber;
  String? picture;
  String? status;
  String? amount;
  String? createdAt;
  String? updatedAt;

  PayoutModel(
      {this.id,
      this.accountBank,
      this.accountNumber,
      this.picture,
      this.status,
      this.createdAt,this.amount,
      this.updatedAt});

  PayoutModel.fromJson(dynamic json) {
    id = json['id'];
    accountBank = json['account_bank'];
    accountNumber = json['account_number'];
    picture = json['picture'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_bank'] = this.accountBank;
    data['account_number'] = this.accountNumber;
    data['amount'] = this.amount;
    data['picture'] = this.picture;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
