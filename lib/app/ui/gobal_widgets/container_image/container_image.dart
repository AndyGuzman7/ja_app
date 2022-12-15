import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import 'package:ja_app/pages/photoUpload.dart';

class ContainerImage1 extends StatelessWidget {
  final dynamic controller;
  final StateProvider provider;
  const ContainerImage1(
      {Key? key, required this.controller, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomImageProvider customImageProvider = CustomImageProvider((File file) {
      controller.onPhotoChanged(file);
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Consumer(builder: (_, watch, __) {
                  final photo = watch.select(
                    provider.select((_) => _.photo),
                  );
                  Image image;
                  log(photo.toString());
                  if (photo != null) {
                    image = Image.file(photo);
                  } else {
                    image = Image.network(
                        "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png");
                  }

                  return Container(
                    child: image,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColorPrimary().materialColor,
                    ),
                    width: 80,
                    height: 80,
                  );
                }),
                Positioned(
                  bottom: -13,
                  right: -10,
                  child: Container(
                    width: 40,
                    padding: EdgeInsets.zero,
                    decoration: const ShapeDecoration(
                      color: Color.fromARGB(233, 203, 229, 241),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.camera_alt),
                      color: CustomColorPrimary().materialColor,
                      onPressed: () {
                        CustomImageProvider customImageProvider =
                            CustomImageProvider((File file) {
                          controller.onPhotoChanged(file);
                        });
                        customImageProvider.getImageCamera();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text("data")
      ],
    );
  }
}
