class UserData {
  int? id;
  String? brandName;
  String? websiteUrl;
  String? picture;
  String? about;
  int? amount;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? phoneNumber;
  String? creating;
  String? role;
  String? userType;
  String? onboardingStep;
  String? bankName;
  String? accName;
  String? accNumber;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? youtubeLink;
  bool? verified;
  String? token;
  dynamic showComplete;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
      this.brandName,
      this.websiteUrl,
      this.picture,
      this.about,
      this.amount,
      this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.password,
      this.phoneNumber,
      this.creating,
      this.role,
      this.userType,
      this.onboardingStep,
      this.bankName,
      this.accName,
      this.accNumber,
      this.facebookLink,
      this.twitterLink,
      this.instagramLink,
      this.youtubeLink,
      this.verified,
      this.token,
      this.showComplete,
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(dynamic json) {
    id = json['id'];
    brandName = json['brandName'];
    websiteUrl = json['websiteUrl'];
    picture = json['picture'];
    about = json['about'];
    amount = json['amount'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    creating = json['creating'];
    role = json['role'];
    userType = json['userType'];
    onboardingStep = json['onboardingStep'];
    bankName = json['bankName'];
    accName = json['accName'];
    accNumber = json['accNumber'];
    facebookLink = json['facebookLink'];
    twitterLink = json['twitterLink'];
    instagramLink = json['instagramLink'];
    youtubeLink = json['youtubeLink'];
    verified = json['verified'];
    token = json['token'];
    showComplete = json['showComplete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.brandName;
    data['websiteUrl'] = this.websiteUrl;
    data['picture'] = this.picture;
    data['about'] = this.about;
    data['amount'] = this.amount;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['creating'] = this.creating;
    data['role'] = this.role;
    data['userType'] = this.userType;
    data['onboardingStep'] = this.onboardingStep;
    data['bankName'] = this.bankName;
    data['accName'] = this.accName;
    data['accNumber'] = this.accNumber;
    data['facebookLink'] = this.facebookLink;
    data['twitterLink'] = this.twitterLink;
    data['instagramLink'] = this.instagramLink;
    data['youtubeLink'] = this.youtubeLink;
    data['verified'] = this.verified;
    data['token'] = this.token;
    data['showComplete'] = this.showComplete;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
