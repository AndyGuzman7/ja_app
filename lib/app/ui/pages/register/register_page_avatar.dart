import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/domain/models/userAvatar.dart';
import 'package:ja_app/app/ui/gobal_widgets/inputs/custom_button.dart';
import 'package:ja_app/app/ui/gobal_widgets/text/custom_title.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import 'controller/register_controller.dart';
import 'controller/register_state.dart';

class RegisterPageAvatar extends StatefulWidget {
  final StateProvider<RegisterController, RegisterState> providerListener;
  const RegisterPageAvatar({
    Key? key,
    required this.providerListener,
  }) : super(key: key);

  @override
  State<RegisterPageAvatar> createState() => _RegisterPageAvatarState();
}

class _RegisterPageAvatarState extends State<RegisterPageAvatar>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const CustomTitle2(
            title: "Hola, Bienvenido/a",
            subTitle: "Selecciona un avatar para tu perfil",
            colorSubTitle: Color.fromARGB(255, 117, 117, 117),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: widget.providerListener.read.loadUserAvatar(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: Consumer(builder: (_, ref, __) {
                      List<UserAvatar> list = ref.select(
                          widget.providerListener.select((_) => _.listAvatar!));

                      return GridView.count(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: 4,
                        children: buildPhotoItem(list, widget.providerListener),
                      );
                    }),
                  );
                } else {
                  return Text("Cargando ...");
                }
              }),
          rowModel(
              CustomButton(
                height: 48,
                colorButton: Color.fromARGB(255, 188, 188, 188),
                textButton: 'Cancelar',
                onPressed: () => widget.providerListener.read
                    .onPressedBtnCancelPageAvatar(context),
              ),
              CustomButton(
                height: 48,
                textButton: 'Siguiente',
                onPressed: () => widget.providerListener.read
                    .onPressedBtnNextPageAvatar(context),
              ))
        ],
      ),
    );
  }

  Row rowModel(widgetOne, widgetTwo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: widgetOne,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(child: widgetTwo),
      ],
    );
  }

  void selectUserAvatar(UserAvatar i, List<UserAvatar> list,
      StateProvider<RegisterController, RegisterState> provider) {
    List<UserAvatar> listNew = list.map((e) {
      e.isSelect = e.name != i.name ? false : true;
      return e;
    }).toList();
    provider.read.onUserAvatarChanged(i);
    provider.read.onListAvatarChanged(listNew);
  }

  Widget containerImage(UserAvatar userAvatar, list, provider) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.network(userAvatar.url).image,
          opacity: userAvatar.isSelect ? 0.2 : 1,
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: () => selectUserAvatar(userAvatar, list, provider),
        child: Align(
          alignment: Alignment.center,
          child: userAvatar.isSelect
              ? Icon(
                  Icons.check_circle_outline,
                  size: 40,
                  color: CustomColorPrimary().materialColor,
                )
              : null,
        ),
      ),
    );
  }

  List<Widget> buildPhotoItem(List<UserAvatar> list, provider) {
    return list.map((e) => containerImage(e, list, provider)).toList();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
