class Image {
  final String storageId;
  final String imageUrl;

  Image({
    required this.storageId,
    required this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json['storageId'] == null || json['imageUrl'] == null) {
      throw ArgumentError('Missing required fields in JSON');
    }

    return Image(
      storageId: json['storageId'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'storageId': storageId,
    'imageUrl': imageUrl,
  };
}