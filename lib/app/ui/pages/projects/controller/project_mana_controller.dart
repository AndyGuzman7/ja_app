import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/domain/repositories/project_mana_repository.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/projects/controller/project_mana_state.dart';

class ProjectManaController extends StateNotifier<ProjectManaState> {
  final SessionController _sessonController;
  String? idUser, idBrochure, canceledAmount;
  bool? isExistBrochureSubscripcion;
  List<String>? listCanceledAmountHistory;
  Brochure? brochure;

  final _projectManaRepository = Get.find<ProjectManaRepository>();
  ProjectManaController(this._sessonController)
      : super(ProjectManaState.initialState) {
    onIdUserChanged(_sessonController.user!.uid);
  }

  Future<List<Brochure>?> getBrochures() async {
    List<Brochure>? listBrochure = [];

    listBrochure = await _projectManaRepository.getBrochures();
    return listBrochure;
  }

  Future<void> startProject() async {
    await _projectManaRepository
        .registerBrochureSubscription(
      BrochureSubscription(
        idUser: state.idUser,
        idBrochure: state.idBrochure,
        canceledAmount: state.canceledAmount,
        listCanceledAmountHistory: state.listCanceledAmountHistory,
      ),
    )
        .then((value) async {
      await verificationBrochureSubscription();
    });
  }

  Future<void> verificationBrochureSubscription() async {
    await getSubscription();
  }

  Future<void> getSubscription() async {
    BrochureSubscription? brochureSubscription =
        await _projectManaRepository.getBrochureSubscription(state.idUser);

    if (brochureSubscription != null) {
      onIsExistBrochureSubscripcion(true);
      onIdBrochure(brochureSubscription.idBrochure);
      onCanceledAmount(brochureSubscription.canceledAmount);
      onIdUserChanged(brochureSubscription.idUser);
      onListCanceledAmount(brochureSubscription.listCanceledAmountHistory);
      print(idBrochure!);
      brochure = await _projectManaRepository.getBrochure(idBrochure!);
    }
  }

  void onIdUserChanged(String text) {
    idUser = text;
    state = state.copyWith(idUser: idUser!);
  }

  void onIsExistBrochureSubscripcion(bool text) {
    isExistBrochureSubscripcion = text;
    state = state.copyWith(isExistBrochureSubscripcion: text);
  }

  void onCanceledAmount(String text) {
    canceledAmount = text;
    state = state.copyWith(canceledAmount: text);
  }

  void onIdBrochure(String text) {
    idBrochure = text;
    state = state.copyWith(idBrochure: text);
  }

  void onListCanceledAmount(List<String> text) {
    listCanceledAmountHistory = text;
    state = state.copyWith(listCanceledAmountHistory: text);
  }
}
