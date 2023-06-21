class Church {
  String id;
  String codeAccess;
  String information;
  List<String> members;
  List<String> eess;
  String name;
  int region;
  String photoURL;

  Church(this.id, this.codeAccess, this.information, this.members, this.eess,
      this.name, this.region, this.photoURL);

  factory Church.fromJson(Map<String, dynamic> json) {
    return Church(
      json['id'],
      json['codeAccess'],
      json['information'],
      List.castFrom(json['members']),
      List.castFrom(json['eess']),
      json['name'],
      json['region'],
      json['photoURL'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'codeAccess': codeAccess,
        'information': information,
        'eess': eess,
        'members': members,
        'name': name,
        'region': region,
        'photoURL': photoURL
      };
}
