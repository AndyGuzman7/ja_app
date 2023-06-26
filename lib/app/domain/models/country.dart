class Country {
  final String name;
  final String extensionNumber;

  Country(this.name, this.extensionNumber);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['name'], json['extensionNumber']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'extensionNumber': extensionNumber,
      };
}
