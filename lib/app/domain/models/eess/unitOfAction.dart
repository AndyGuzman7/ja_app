class UnitOfAction {
  String id;
  String idEESS;
  String leader;
  String name;
  List<String> members;

  UnitOfAction(
    this.id,
    this.idEESS,
    this.leader,
    this.name,
    this.members,
  );

  factory UnitOfAction.fromJson(Map<String, dynamic> json) {
    return UnitOfAction(
      json['id'],
      json['idEESS'],
      json['leader'],
      json['name'],
      json['members'] != null ? List.castFrom(json['members']) : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'idEESS': idEESS,
        'leader': leader,
        'name': name,
        'members': members
      };
}
