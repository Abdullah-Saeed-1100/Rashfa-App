import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rashfa_app/components/crud.dart';
import 'package:rashfa_app/components/valid.dart';
import 'package:rashfa_app/constant/linkapi.dart';
import 'package:rashfa_app/model/juicesmodel.dart';
import 'package:rashfa_app/widgets/customtextformfiled.dart';

class EditItem extends StatefulWidget {
  final JuiceModel juiceModel;
  const EditItem({
    super.key,
    required this.juiceModel,
  });

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  File? myFile;
  bool isHereFile = false;

  editJuice() async {
    if (formstate.currentState!.validate()) {
      // عرفناه لحاله لأننا بنستخدمه تحت في التحقق
      var response;
      // يعني اذا المستخدم عدل الملاحظه ولكن لم يعدل الصورة
      if (myFile == null) {
        response = await postRequest(linkEditjuices, {
          "name": nameController.text,
          "price": priceController.text,
          "imageName": widget.juiceModel.juicesImage.toString(),
          // آي دي الملاحظه وليس المستخدم
          "juice_id": widget.juiceModel.juicesId.toString(),
        });
      }
      // يعني اذا المستخدم عدل الملاحظه والصورة مع بعض
      else {
        response = await postRequestWithFile(
            linkEditjuices,
            {
              "name": nameController.text,
              "price": priceController.text,
              "imageName": widget.juiceModel.juicesImage.toString(),
              // آي دي الملاحظه وليس المستخدم
              "juice_id": widget.juiceModel.juicesId.toString()
            },
            myFile!);
      }
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("image eror");
      }
    }
  }

  @override
  void initState() {
    // نعطيهن قيمة ابتدائية
    // هذي ودجت تقدر من خلالها توصل للبارامترات حق الكلاس الأعلى
    nameController.text = widget.juiceModel.juicesName!;
    priceController.text = widget.juiceModel.juicesPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rashfa",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.2),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: formstate,
            child: ListView(
              children: [
                // =============================================
                const SizedBox(
                  height: 20,
                ),
                // =============================================
                MaterialButton(
                  color: isHereFile
                      ? Colors.green.shade900
                      : Colors.green.shade200,
                  onPressed: () async {
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    myFile = File(xfile!.path);
                    setState(() {
                      // عشان بس يتحدث لون الزر بعد اختيار الصورة
                      isHereFile = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "إضافة صورة من المعرض",
                      style: TextStyle(
                        color: isHereFile ? Colors.white : Colors.black87,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // =============================================
                MaterialButton(
                    color: isHereFile
                        ? Colors.green.shade900
                        : Colors.green.shade200,
                    onPressed: () async {
                      // الكاميرا في المحاكي يعطينا خطأ
                      XFile? xfile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      myFile = File(xfile!.path);
                      setState(() {
                        // عشان بس يتحدث لون الزر بعد اختيار الصورة
                        isHereFile = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "إضافة صورة من الكاميرا",
                        style: TextStyle(
                          color: isHereFile ? Colors.white : Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                    )),
                // =============================================
                const SizedBox(height: 55),
                // =============  Text Form Filed  =============
                CustomTextFormFiled(
                  hint: "اسم المشروب",
                  icon: const Icon(Icons.title_rounded),
                  myCcontroller: nameController,
                  myValid: (val) {
                    return validInput(val!, 1, 15);
                  },
                  typeKeyword: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFiled(
                  hint: "السعر",
                  icon: const Icon(Icons.attach_money_rounded),
                  myCcontroller: priceController,
                  myValid: (val) {
                    return validInput(val!, 1, 3);
                  },
                  typeKeyword: TextInputType.number,
                ),
                // =============================================
                const SizedBox(
                  height: 60,
                ),
                // =============================================
                MaterialButton(
                  color: Colors.orange[800],
                  onPressed: () async {
                    await editJuice();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "حفظ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
