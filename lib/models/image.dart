class ImageM {
  final String url;
  final String storagePath;


  ImageM({required this.url, required this.storagePath, required String imageUrl, required String storageId});

  factory ImageM.fromJson(Map<String, dynamic> json) {
    return ImageM(
      url: json['url'] as String,
      storagePath: json['storagePath'] as String, imageUrl: '', storageId: '',
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'storagePath': storagePath,
  };
}
