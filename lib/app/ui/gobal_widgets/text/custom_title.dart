import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool? isBoldTitle;
  const CustomTitle(
      {Key? key, required this.title, this.isBoldTitle, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0, right: 0),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: isBoldTitle != null ? FontWeight.normal : null,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            )
          : null,
    );
  }
}

class CustomTitle2 extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool? isBoldTitle;
  final Color colorTitle;
  final Color colorSubTitle;
  final double? fontSize;

  final TextAlign textAlignTitle;
  final TextAlign textAlignSubTitle;
  const CustomTitle2(
      {Key? key,
      this.fontSize,
      required this.title,
      this.isBoldTitle = false,
      this.subTitle,
      this.colorTitle = Colors.black,
      this.colorSubTitle = Colors.black,
      this.textAlignSubTitle = TextAlign.justify,
      this.textAlignTitle = TextAlign.justify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      contentPadding:
          const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      title: Text(
        title,
        textAlign: textAlignTitle,
        style: TextStyle(
          fontSize: fontSize ?? 20,
          color: colorTitle,
          fontWeight: isBoldTitle! ? FontWeight.bold : null,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              "\n" + subTitle!,
              textAlign: textAlignSubTitle,
              style: TextStyle(color: colorSubTitle, fontSize: 15),
            )
          : null,
    );
  }
}

class CustomTitle3 extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool? isBoldTitle;
  final Color colorTitle;
  final Color colorSubTitle;
  final double? fontSize;

  final TextAlign textAlignTitle;
  final TextAlign textAlignSubTitle;
  const CustomTitle3(
      {Key? key,
      this.fontSize,
      required this.title,
      this.isBoldTitle = false,
      this.subTitle,
      this.colorTitle = Colors.black,
      this.colorSubTitle = Colors.black,
      this.textAlignSubTitle = TextAlign.justify,
      this.textAlignTitle = TextAlign.justify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      contentPadding:
          const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      title: Text(
        title,
        textAlign: textAlignTitle,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          color: colorTitle,
          fontWeight: isBoldTitle! ? FontWeight.bold : null,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              "\n" + subTitle!,
              textAlign: textAlignSubTitle,
              style: TextStyle(color: colorSubTitle, fontSize: 13),
            )
          : null,
    );
  }
}
