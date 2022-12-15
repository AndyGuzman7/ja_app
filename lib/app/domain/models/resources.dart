class Resources {
  final List<String> images;

  Resources(this.images);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'images': images,
      };

  Resources.fromJson(Map<String, dynamic> json)
      : images = List.castFrom(json['images']);
}
