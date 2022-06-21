import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ja_app/components/Button_app.dart';
import 'package:ja_app/components/CustomTextFieldv2.dart';
import 'package:ja_app/components/CustomTextFiled.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({Key? key}) : super(key: key);

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  XFile? sampleImage;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? const Text("Select to Image")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Image.file(
              File(sampleImage!.path),
              height: 300.0,
              width: 600.0,
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: CustomTextFiled(
                fillColor: Color.fromARGB(255, 236, 236, 236),
                focusColor: Colors.white,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: CustomTextFieldv2(
                  typeIput: TextInputType.number,
                  hint: "Número de pasajeros",
                  multiValidator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Número de pasajeros requerido'),
                  ]),
                  marginLeft: 0,
                  marginRight: 0,
                  heightNum: 42,
                )),
            ButtonApp(
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              text: "sadasd",
            ),
            TextFormField(
              cursorColor: Theme.of(context).cursorColor,
              initialValue: 'Input text',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.favorite),
                labelText: 'Label text',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
                helperText: 'Helper text',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
