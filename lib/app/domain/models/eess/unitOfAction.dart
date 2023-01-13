class UnitOfAction {
  String id;
  String name;
  List<String> members;

  UnitOfAction(this.id, this.name, this.members);

  factory UnitOfAction.fromJson(Map<String, dynamic> json) {
    return UnitOfAction(
      json['id'],
      json['name'],
      json['members'] != null ? List.castFrom(json['members']) : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'members': members,
      };
}
