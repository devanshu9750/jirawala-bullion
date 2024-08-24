class User {
  int? id;
  String? name;
  String? mobileNo;
  String? password;
  int? bullionOwnerId;
  bool? isDeleted;

  User({this.id, this.name, this.mobileNo, this.password, this.bullionOwnerId, this.isDeleted});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    bullionOwnerId = json['bullion_owner_id'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_no'] = mobileNo;
    data['password'] = password;
    data['bullion_owner_id'] = bullionOwnerId;
    data['is_deleted'] = isDeleted;
    return data;
  }

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) => other is User && other.id == id;

  @override
  int get hashCode => id ?? -1;
}
