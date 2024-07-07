class Tag {
  final String tagId;
  final List<String> postIds;

  Tag({
    required this.tagId,
    this.postIds = const [],
  });
}
