import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/controller/members_page_controller/members_page_functions.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/controller/sabbatical_school_controller.dart';
import 'package:ja_app/app/ui/pages/sabbatical_school/sabbatical_school_page.dart';
import '../../../../../data/repositories/eess_repository/eess_repository.dart';
import '../../../../global_controllers/session_controller.dart';
import '../../../../routes/routes.dart';
import 'members_page_state.dart';

final membersPageProvider =
    StateProvider<MembersPageController, MembersPageState>(
        (_) => MembersPageController(
            sessionProvider.read, sabbaticalSchoolProvider.read),
        autoDispose: true);

class MembersPageController extends StateNotifier<MembersPageState> {
  final SessionController sessionController;
  final SabbaticalSchoolController _eeSsController;
  final GlobalKey<FormState> formKeyRegisterUnitOfAction = GlobalKey();
  final _eess = Get.find<EESSRepository>();
  late final MembersPageFunctions membersPageFunctions;

  MembersPageController(this.sessionController, this._eeSsController)
      : super(MembersPageState.initialState) {
    membersPageFunctions = MembersPageFunctions(_eeSsController);
  }

  loadDataToShowBoxMembersNone() async {
    var lisMembersNone = await membersPageFunctions.getMembersNoneEESS();
  }

  onPressedBtnAddMembers(context) async {
    ProgressDialog.show(context, double.infinity, double.infinity);
    List<UserData> list = state.membersEESSNew;
    final result = await membersPageFunctions
        .registerMembersToEESS(list.map((e) => e.id).toList());

    if (result) {
      await loadPageData();
    }
    router.pop();
  }

  onPressedBtnCreateMember(context) async {
    UserData userData = await router.pushNamed(Routes.REGISTER);
    ProgressDialog.show(context, double.infinity, double.infinity);
    final result = await membersPageFunctions.createMemberToEESS(userData);
    if (result) await loadPageData();
    router.pop();
  }

  onPressedBtnCancel() {
    membersPageFunctions.closePage();
  }

  Future loadPageData() async {
    final response = await membersPageFunctions.getMembersEESS();
    onChangedMembersEESS(response);
  }

  onChangedListMembersNone(List<UserData> users) {
    state = state.copyWith(membersEESSNone: users);
  }

  onChangedListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.contains(user)
        ? removeListMembersSelected(user)
        : addListMembersSelected(user);
  }

  addListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.add(user);
    state = state.copyWith(membersEESSNew: list);
  }

  removeListMembersSelected(UserData user) {
    List<UserData> list = state.membersEESSNew;
    list.remove(user);
    state = state.copyWith(membersEESSNew: list);
  }

  void onChangedUnitOfAction(UnitOfAction unitOfAction) {
    state = state.copyWith(unitOfAction: unitOfAction);
  }

  void onChangedListUnitOfAction(List<UnitOfAction> list) {
    state = state.copyWith(listUnitOfAction: list);
    if (list.isNotEmpty) {
      onChangedUnitOfAction(list.first);
    }
  }

  void onChangedNameCreateUnitOfAction(String name) {
    state = state.copyWith(nameUnitOfActionCreate: name);
  }

  void onChangedUserDateCreateUnitOfAction(UserData user) {
    state = state.copyWith(userDataUnitOfActionCreate: user);
  }

  void onChangedMembersEESS(List<UserData> list) {
    state = state.copyWith(membersEESS: list);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
