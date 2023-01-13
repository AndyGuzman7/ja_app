import 'dart:developer';

import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';

class EESS {
  final String? id;
  final List<String>? members;
  late final String? name;
  final String? information;
  final String? photoURL;
  final List<UnitOfAction> unitOfAction;

  EESS(this.id, this.members, this.name, this.information, this.photoURL,
      this.unitOfAction);

  factory EESS.fromJson(Map<String, dynamic> json) {
    List<UnitOfAction> convertList(List<dynamic> json) {
      List<UnitOfAction> list = [];
      //json.map((key, value) => null)
      json.forEach((value) {
        list.add(UnitOfAction.fromJson(value));
        //print('$value');
        //listBrochures.add(Brochure.fromJson(value));
      });
      return list;
    }

    return EESS(
      json['id'],
      json['members'] != null ? List.castFrom(json['members']) : [],
      json['name'],
      json['information'],
      json['photoURL'],
      json['unitOfAction'] != null ? convertList(json['unitOfAction']) : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'information': information,
        'members': members,
        'name': name,
        'photoURL': photoURL,
        'unitOfAction': unitOfAction
      };
}
