class Video{
  final String videoUrl;
  final String thumbUrl;
  final String name;

  Video({
    required this.videoUrl, required this.thumbUrl, required this.name,
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "videoUrl": videoUrl,
      "thumbUrl": thumbUrl,
      "name": name,
    };
  }
}