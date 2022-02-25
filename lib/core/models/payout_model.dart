class PayoutModel {
  String? userId;
  String? accountBank;
  String? accountNumber;
  String? reference;
  String? narration;
  int? amount;
  String? createdAt;
  String? updatedAt;

  PayoutModel(
      {this.userId,
      this.accountBank,
      this.accountNumber,
      this.reference,
      this.narration,
      this.createdAt,this.amount,
      this.updatedAt});

  PayoutModel.fromJson(dynamic json) {
    userId = json['userId'];
    accountBank = json['account_bank'];
    accountNumber = json['account_number'];
    reference = json['reference'];
    amount = json['amount'];
    narration = json['narration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['account_bank'] = this.accountBank;
    data['account_number'] = this.accountNumber;
    data['amount'] = this.amount;
    data['reference'] = this.reference;
    data['narration'] = this.narration;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
