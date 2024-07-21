class ImageM { //Very often confused with Image in Flutter
  final String storageId;
  final String imageUrl;

  ImageM({
    required this.storageId,
    required this.imageUrl,
  });

  factory ImageM.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json['storageId'] == null || json['imageUrl'] == null) {
      throw ArgumentError('Missing required fields in JSON');
    }

    return ImageM(
      storageId: json['storageId'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'storageId': storageId,
    'imageUrl': imageUrl,
  };
}