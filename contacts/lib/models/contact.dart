class Contact {
  late final String fullName;
  late final String mobileNo;
  late final int id;

  Contact({required this.fullName, required this.mobileNo, required this.id});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
