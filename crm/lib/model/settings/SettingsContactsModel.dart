class SettingsContactsModel {
  final String companyName;
  final String phoneNumber;
  final String email;
  final String facebook;
  final String instagram;
  final String twitter;
  final String linkedIn;

  SettingsContactsModel(
      this.companyName,
      this.phoneNumber,
      this.email,
      this.facebook,
      this.instagram,
      this.twitter,
      this.linkedIn);

  SettingsContactsModel.fromJson(Map<String, dynamic> json) :
        companyName = json["companyName"],
        phoneNumber = json["phoneNumber"],
        email = json["email"],
        facebook = json["facebook"],
        instagram = json["instagram"],
        twitter = json["twitter"],
        linkedIn = json["linkedIn"];

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "phoneNumber": phoneNumber,
    "email": email,
    "facebook": facebook,
    "instagram": instagram,
    "twitter": twitter,
    "linkedIn": linkedIn
  };
}