class WCR {
  late final String pickUpLocation;
  late final String publicId;
  late final String wasteType;
  late final String wasteDesc;
  late final String wastePhoto;
  late final int status;
  late final String createdAt;
  late final String? price;
  late final String? collectionDatetime;
  late final String? collectorUnit;

  WCR({
    required this.pickUpLocation,
    required this.publicId,
    required this.wasteType,
    required this.wasteDesc,
    required this.wastePhoto,
    required this.status,
    required this.createdAt,
    this.price,
    this.collectionDatetime,
    this.collectorUnit,
  });

  WCR.fromJson(dynamic json) {
    pickUpLocation = json['pick_up_location'];
    publicId = json['public_id'];
    wasteType = json['waste_type'];
    wasteDesc = json['waste_desc'];
    wastePhoto = json['waste_photo'];
    collectionDatetime = json['collection_datetime'];
    status = json['status'];
    createdAt = json['created_at'];
    price = json["price"];
    collectorUnit = json['collector_unit'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pick_up_location'] = pickUpLocation;
    map['public_id'] = publicId;
    map['waste_type'] = wasteType;
    map['waste_desc'] = wasteDesc;
    map['waste_photo'] = wastePhoto;
    map['collection_datetime'] = collectionDatetime;
    map['status'] = status;
    map['created_at'] = createdAt;
    map["price"] = price;
    map['collector_unit'] = collectorUnit;
    return map;
  }
}