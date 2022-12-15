import 'dart:convert';

class BrochureSubscription {
  String? idUser, idBrochure, canceledAmount;
  List<String>? listCanceledAmountHistory;

  BrochureSubscription(
      {required this.idUser,
      required this.idBrochure,
      required this.canceledAmount,
      required this.listCanceledAmountHistory});
  BrochureSubscription.inits();
  Map<String, dynamic> toJson() => <String, dynamic>{
        'idUser': idUser,
        'idBrochure': idBrochure,
        'canceledAmount': canceledAmount,
        'listCanceledAmountHistory':
            listCanceledAmountHistory!.map((e) => e).toList(),
      };

  BrochureSubscription.fromJson(Map<String, dynamic> json)
      : idUser = json['idUser'],
        idBrochure = json['idBrochure'],
        canceledAmount = json['canceledAmount'],
        listCanceledAmountHistory =
            List.castFrom(json['listCanceledAmountHistory']);
}
