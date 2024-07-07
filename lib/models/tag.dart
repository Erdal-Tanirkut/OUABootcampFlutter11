class Tag {
  final String tagId;
  final List<String> postIds;

  Tag({
    required this.tagId,
    this.postIds = const [],
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    // Validate required field
    if (json['tagId'] == null) {
      throw ArgumentError('Missing required field in JSON: tagId');
    }

    return Tag(
      tagId: json['tagId'] as String,
      postIds: (json['postIds'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'tagId': tagId,
    'postIds': postIds,
  };
}
