class UserLocation {
  late final String id;
  late final String name;
  late final String latitude;
  late final String longitude;

  UserLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  UserLocation.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}