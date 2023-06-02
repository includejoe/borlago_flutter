class User {
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String phone;
  late final String? momoNumber;
  late final String gender;
  late final String country;
  late final int userType;
  late final String createdAt;
  late final String? profilePhoto;
  late final String? collectorId;

  User({
      required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.momoNumber,
      required this.gender,
      required this.country,
      required this.userType,
      required this.createdAt,
      required this.profilePhoto,
      required this.collectorId,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    momoNumber = json['momo_number'];
    gender = json['gender'];
    country = json['country'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    profilePhoto = json['profile_photo'];
    collectorId = json['collector_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone'] = phone;
    map['momo_number'] = momoNumber;
    map['gender'] = gender;
    map['country'] = country;
    map['user_type'] = userType;
    map['created_at'] = createdAt;
    map['profile_photo'] = profilePhoto;
    map['collector_id'] = collectorId;
    return map;
  }

}