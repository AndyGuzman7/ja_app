import 'dart:developer';

import 'package:flutter_meedu/meedu.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/pages/projects/controller/project_mana_state.dart';

import '../../../../data/repositories/project_mana_repository/project_mana_repository.dart';
import '../../../../data/repositories/user_repository/user_repository.dart';

class ProjectManaController extends StateNotifier<ProjectManaState> {
  final SessionController _sessonController;

  final _projectManaRepository = Get.find<ProjectManaRepository>();
  final _userRepository = Get.find<UserRepository>();

  ProjectManaController(this._sessonController)
      : super(ProjectManaState.initialState) {
    onIdUserChanged(_sessonController.userData!.userFirebase!.uid);
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
      await getSubscription();
    });
  }

  Future<bool> getSubscription() async {
    BrochureSubscription? brochureSubscription =
        await _projectManaRepository.getBrochureSubscription(state.idUser);

    if (brochureSubscription != null) {
      onIdBrochure(brochureSubscription.idBrochure!);
      onCanceledAmount(brochureSubscription.canceledAmount!);
      onIdUserChanged(brochureSubscription.idUser!);
      onListCanceledAmount(brochureSubscription.listCanceledAmountHistory!);

      final brochure =
          await _projectManaRepository.getBrochure(state.idBrochure);
      onBrochure(brochure!);
      onBrochureSubscription(brochureSubscription);
      onIsExistBrochureSubscripcion(true);
      return true;
    }
    return false;
  }

  void onBrochureSubscription(BrochureSubscription brochureSubscription) {
    state = state.copyWith(brochureSubscription: brochureSubscription);
  }

  void onIdUserChanged(String text) {
    state = state.copyWith(idUser: text);
  }

  void onIsExistBrochureSubscripcion(bool text) {
    state = state.copyWith(isExistBrochureSubscripcion: text);
  }

  void onCanceledAmount(String text) {
    state = state.copyWith(canceledAmount: text);
  }

  void onBrochure(Brochure brochure) {
    state = state.copyWith(brochure: brochure);
  }

  void onIdBrochure(String text) {
    state = state.copyWith(idBrochure: text);
  }

  void onListCanceledAmount(List<String> text) {
    state = state.copyWith(listCanceledAmountHistory: text);
  }
}
