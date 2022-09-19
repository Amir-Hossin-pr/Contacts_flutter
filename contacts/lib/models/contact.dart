class Contact {
  late final String fullName;
  late final String mobileNo;

  Contact({required this.fullName, required this.mobileNo});

  Contact.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['FullName'] = this.fullName;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
