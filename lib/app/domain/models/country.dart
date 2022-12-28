class Country {
  final String name;
  final String extensionNumber;

  Country(this.name, this.extensionNumber);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['name'], json['extensionNumber']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'extensionNumber': extensionNumber,
      };
}
