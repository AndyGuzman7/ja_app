import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/brochure.dart';
import 'package:ja_app/app/domain/models/brochureSubscription.dart';
import 'package:ja_app/app/ui/global_controllers/session_controller.dart';
import 'package:ja_app/app/ui/gobal_widgets/container/custom_container_image_rounded.dart';
import 'package:ja_app/app/ui/gobal_widgets/container/custom_container_information.dart';
import 'package:ja_app/app/ui/gobal_widgets/container/custom_container_rounded.dart';

import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/ui/gobal_widgets/dialogs/progress_dialog.dart';
import 'package:ja_app/app/ui/gobal_widgets/drop_dow/custom_dropDownButton.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_paragraph.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title_center.dart';
import 'package:ja_app/app/ui/pages/projects/controller/project_mana_controller.dart';
import 'package:ja_app/app/ui/pages/projects/controller/project_mana_state.dart';
import 'package:ja_app/app/ui/pages/projects/widgets/admin/project_mana_page_admin.dart';
import 'package:ja_app/app/utils/MyColors.dart';

final projectManaPageProvider =
    StateProvider<ProjectManaController, ProjectManaState>(
        (_) => ProjectManaController(sessionProvider.read));

class ProjectManaPage extends StatelessWidget {
  const ProjectManaPage({Key? key}) : super(key: key);

  Widget atributeData(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(child: CustomTitle2(title: text1)),
          Expanded(
              child: CustomTitle2(
            title: text2,
            isBoldTitle: true,
            textAlignTitle: TextAlign.right,
          )),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String text, String? message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final GlobalKey<FormState> formKey = GlobalKey();
        return AlertDialog(
          actionsPadding: EdgeInsets.all(20),
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          title: Text(
            text,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: FutureBuilder<List<Brochure>?>(
              future: projectManaPageProvider.read.getBrochures(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Form(
                    key: formKey,
                    child: CustomDropDownButton(
                      onChanged: (value) {
                        projectManaPageProvider.read.onIdBrochure(value.id!);
                      },
                      listBrochure: snapshot.data!,
                      validator: (text) {
                        print(text);
                        if (text == null) return "Seleccione un item";
                      },
                    ),
                  );
                }
                return Text('Load Brochures');
              },
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    textButton: 'Cancel',
                    colorTextButton: CustomColorPrimary().materialColor,
                    colorButton: Colors.white54,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomButton(
                  textButton: 'Accept',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      startProject(context);
                      Navigator.pop(context);
                    }
                  },
                ))
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> startProject(BuildContext context) async {
    final controller = projectManaPageProvider.read;
    //final isValidForm = controller.formKey.currentState!.validate();

    ProgressDialog.show(context);
    await controller.startProject();
    router.pop();

    //router.pushNamedAndRemoveUntil(Routes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingMain = EdgeInsets.only(left: 20, right: 20);
    EdgeInsets paddingMain2 = EdgeInsets.all(20);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(labelColor: Colors.black, tabs: [
            Tab(
              text: 'Información',
            ),
            Tab(
              text: 'Administrador',
            )
          ]),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          FutureBuilder(
            future: projectManaPageProvider.read.getSubscription(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                          "https://files.adventistas.org/institucional/es/sites/18/2022/04/Mana-2-ES.jpg"),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: CustomTitle(title: 'Mana Project'),
                            ),
                            Consumer(builder: (_, ref, __) {
                              log("starts button");
                              final brochure = ref.select(
                                  projectManaPageProvider.select(
                                      (_) => _.isExistBrochureSubscripcion));

                              log(brochure.toString());
                              if (!brochure) {
                                return Expanded(
                                  child: CustomButton(
                                    textButton: 'Start project',
                                    height: 50,
                                    onPressed: () {
                                      showAlertDialog(
                                          context,
                                          'Escoje tu folleto de escuela sabatica',
                                          '');
                                      //startProject(context);
                                    },
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                      const CustomParagraph(
                        padding: EdgeInsets.all(20),
                        paragraph:
                            'El proyecto maná es un esfuerzo unido de la iglesia, para alcanzar el mayor número de personas de todas las edades con la lección de Escuela Sabática, y motivarlas en el estudio diario de la Palabra de Dios.',
                      ),
                      CustomContainerRounded(
                        child: Row(
                          children: [
                            CustomContainerImageRounded(
                                child: Image.network(
                                    "https://articles.collegebol.com/wp-content/uploads/2020/06/group-young-people-posing-photo_52683-18823.jpg")),
                            const SizedBox(width: 20),
                            const Expanded(
                                child: CustomTitle2(
                              colorTitle: Colors.white,
                              title: 'El plan del espacio Joven',
                              colorSubTitle: Colors.white,
                              subTitle:
                                  'Pago por cuotas de dinero para que cada miembro cuente con la suscripción para el año 2023',
                            )),
                          ],
                        ),
                      ),
                      Consumer(builder: (_, ref, __) {
                        final brochure = ref.select(projectManaPageProvider
                            .select((_) => _.isExistBrochureSubscripcion));

                        if (brochure) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: CustomTitle2(
                                  title: 'Proyecto Maná Espacio Joven HDFE',
                                  subTitle: 'Miembro Espacio Joven: ' +
                                      sessionProvider.read.user!.displayName!,
                                  //colorSubTitle: CustomColorPrimary().materialColor,
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: paddingMain,
                                child: const CustomTitleCenterH4(
                                  text: 'Monto Cancelado hasta la fecha',
                                ),
                              ),
                              Padding(
                                padding: paddingMain,
                                child: Consumer(
                                  builder: (_, ref, __) {
                                    String amountCanceled = ref
                                        .watch(projectManaPageProvider)
                                        .state
                                        .canceledAmount;
                                    return CustomContainerRounded(
                                      widthAuto: true,
                                      child: CustomTitleCenterH1(
                                        colorText: Colors.white,
                                        text: amountCanceled == ''
                                            ? 'Bs 0'
                                            : 'Bs ' + amountCanceled,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Consumer(builder: (_, ref, __) {
                                final Brochure? brochure = ref.select(
                                    projectManaPageProvider
                                        .select((p0) => p0.brochure));
                                return Column(
                                  children: [
                                    atributeData('Lección ${brochure?.spanish}',
                                        'BS ${brochure?.price}'),
                                  ],
                                );
                              }),
                              Consumer(builder: (_, ref, __) {
                                final BrochureSubscription?
                                    brochureSubscription = ref.select(
                                  projectManaPageProvider
                                      .select((p0) => p0.brochureSubscription),
                                );

                                final int? countCanceledAmount =
                                    brochureSubscription
                                        ?.listCanceledAmountHistory!.length;

                                final double? priceLection = double.parse(
                                    projectManaPageProvider
                                        .read.state.brochure!.price!);

                                String? canceledAmount =
                                    brochureSubscription?.canceledAmount;
                                log(canceledAmount.toString());

                                final double canceled = double.parse(
                                    '${canceledAmount == '' ? 0.0 : canceledAmount ?? 0.0}');
                                print(canceled);
                                return Column(
                                  children: [
                                    const Divider(),
                                    atributeData('Cuotas canceladas',
                                        '${countCanceledAmount ?? 0}'),
                                    const Divider(),
                                    atributeData('Monto faltante',
                                        '${(priceLection! - canceled)}'),
                                  ],
                                );
                              }),
                              Divider(),
                              atributeData(
                                  'Fecha Culminación', '22 Octubre, 2022'),
                              const CustomContainerInformation(
                                backgroundColor:
                                    Color.fromARGB(255, 145, 195, 237),
                                colorText: Colors.white,
                                icon: Icon(Icons.info, color: Colors.white),
                                text:
                                    'La cancelación de las cuotas debe realizarse a los encargados de la mesa directiva del Espacio Joven.',
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                );
              } else {
                return WillPopScope(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Color.fromARGB(255, 255, 255, 255),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    onWillPop: () async => false);
              }
            },
          ),
          ProjectManaPageAdmin()
        ]),
      ),
    );
  }
}
