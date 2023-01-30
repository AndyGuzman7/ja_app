import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ja_app/app/data/repositories/eess_impl/eess_repository.dart';
import 'package:ja_app/app/data/repositories/unitOfAction_impl/unitOfAction_repository.dart';
import 'package:ja_app/app/data/repositories/user_impl/user_repository.dart';
import 'package:ja_app/app/domain/models/eess/eess.dart';
import 'package:ja_app/app/domain/models/eess/unitOfAction.dart';
import 'package:ja_app/app/domain/models/user_data.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/dialogs.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/pages/eess/controller/eess_controller.dart';
import 'package:ja_app/app/ui/pages/eess/controller/members_page_controller/members_page_state.dart';
import 'package:ja_app/app/ui/pages/eess/controller/unit_page_controller/unit_page_state.dart';
import 'package:ja_app/app/utils/email_service.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:ja_app/app/ui/routes/routes.dart';

import '../../../../../data/repositories/target_virtual/target_virtual_repository.dart';
import '../../../../global_controllers/session_controller.dart';

class UnitPageController extends StateNotifier<UnitPageState> {
  final SessionController _sessionController;
  final EeSsController _eeSsController;

  List<UserData> membersSelected = [];
  String? _routeName;
  String? get routeName => _routeName;
  final userRepository = Get.find<UserRepository>();

  final _targetVirtual = Get.find<TargetVirtualRepository>();

  final GlobalKey<FormState> formKey = GlobalKey();

  final GlobalKey formKey2 = GlobalKey();

  final GlobalKey<FormState> formKeyRegisterUnitOfAction = GlobalKey();

  final _eess = Get.find<EESSRepository>();
  final _unitOfAction = Get.find<UnitOfActionRepository>();
  UnitPageController(this._sessionController, this._eeSsController)
      : super(UnitPageState.initialState);

  onPressedRegisterUnitOfAction(context) async {
    final isReady = formKeyRegisterUnitOfAction.currentState;

    if (isReady != null) {
      final validator = formKeyRegisterUnitOfAction.currentState!.validate();
      if (validator) {
        await registerUnitOfAction(context);

        router.pop(context);
      }
    }
  }

  Future registerUnitOfAction(context) async {
    ProgressDialog.show(context);

    final response = await _unitOfAction.registerUnitOfAction(
        state.nameUnitOfActionCreate!,
        state.userDataUnitOfActionCreate!.id,
        _eeSsController.state.eess!.id!);

    final responseRegisterMember = await _unitOfAction
        .registerMemberUnitOfAction([state.userDataUnitOfActionCreate!.id],
            response!.idEESS, response.id);
    await _targetVirtual.registerTargetVirtual(response.id);
    router.pop(context);

    if (response != null && responseRegisterMember) {
      await Dialogs.alert(context,
          title: "Registro", content: "Registro exitoso");
      await loadPageData();
    } else {
      Dialogs.alert(context, title: "Invalido", content: "Codigo invalido");
    }
  }

  onChangedListMembersSelected(UserData user) {
    List<UserData> list = state.membersUnitOfActionNew;
    list.contains(user)
        ? removeListMembersSelected(user)
        : addListMembersSelected(user);
  }

  onPressedAddMembers(context) async {
    ProgressDialog.show(context);
    final List<UserData> list = state.membersUnitOfActionNew;
    final String idUnitOfAction = state.unitOfAction!.id;

    List<String> listIdS = [];
    for (var element in list) {
      listIdS.add(element.id);
    }
    final idEess = _eeSsController.state.eess!.id;

    final response = await _unitOfAction.registerMemberUnitOfAction(
        listIdS, idEess!, idUnitOfAction);

    if (response) {
      state = state.copyWith(membersUnitOfActionNew: []);

      await getMembersToUnitOfAction(state.unitOfAction!.id);
      // router.pop(context);
    }
    router.pop(context);
  }

  addListMembersSelected(UserData user) {
    List<UserData> list = state.membersUnitOfActionNew;
    list.add(user);
    state = state.copyWith(membersUnitOfActionNew: list);
  }

  removeListMembersSelected(UserData user) {
    List<UserData> list = state.membersUnitOfActionNew;
    list.remove(user);
    state = state.copyWith(membersUnitOfActionNew: list);
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

  void onChangedListMembersUnitOfAction(List<UserData> list) {
    state = state.copyWith(membersUnitOfAction: list);
  }

  void onChangedNameCreateUnitOfAction(String name) {
    state = state.copyWith(nameUnitOfActionCreate: name);
  }

  void onChangedUserDateCreateUnitOfAction(UserData user) {
    state = state.copyWith(userDataUnitOfActionCreate: user);
  }

  Future<List<UserData>> getListMembers() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(_eeSsController.state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>> getUnitOfAction() async {
    List<UserData> listUserData = [];
    listUserData = await _eess.getMembersEESS(_eeSsController.state.eess!.id!);
    return listUserData;
  }

  Future<List<UserData>>? getMembersToUnitOfAction(String idUnitAction) async {
    final response = await _unitOfAction.getMembersToUnitAction(idUnitAction);

    onChangedListMembersUnitOfAction(response);

    return response;
  }

  Future<List<UnitOfAction>> getUnitOfActionByEESS() async {
    final idEESS = _eeSsController.state.eess!.id;
    final unitOfActions = await _unitOfAction.getUnitOfActionAllByEESS(idEESS!);
    return unitOfActions;
  }

  Future<List<UserData>>? getMembersNoneUnitOfAction() async {
    final idEESS = _eeSsController.state.eess!.id;
    final response =
        await _unitOfAction.getMembersEESSNoneToUnitOfAction(idEESS!);
    return response;
  }

  Future loadPageData() async {
    final response = await getUnitOfActionByEESS();
    onChangedListUnitOfAction(response);
    //return response;
  }

  Future<UserData?> getUser(String idUser) async {
    UserData? data;
    try {
      data = await userRepository.getUser(idUser);
      return data!;
    } catch (e) {
      return null;
    }
  }

  sendEmail() async {
    EmailService emailService = EmailService("andyguzman117@gmail.com",
        "Registro de miembro " + DateTime.now().toString(), "");
    await emailService.sendEmail();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class GoogleAuthApi {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?> signIng() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }

  static Future signOut() => _googleSignIn.signOut();
}
