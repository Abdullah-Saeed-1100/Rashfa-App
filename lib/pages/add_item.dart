import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rashfa_app/components/crud.dart';
import 'package:rashfa_app/components/valid.dart';
import 'package:rashfa_app/constant/linkapi.dart';
import 'package:rashfa_app/widgets/customtextformfiled.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> with Crud {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  File? myFile;
  bool isHereFile = false;
  // في البداية ترو عشان ماتجي رسالة اول ماتفتح الصفحة
  bool messageForImage = true;
  addJuice() async {
    // نسوي تصميم رسالة الرجاء ادخال الصورة
    // مابعد الشرط الأول يسمى الكود الميت
    if (myFile == null) {
      print("=====  الرجاء ادخال ملف في البداية");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("حسنا"),
                  )
                ],
                title: const Text(
                  "تنبية:",
                ),
                contentPadding: const EdgeInsets.all(20),
                content: const Text("الرجاء ادخال صورة"),
              ));
      setState(() {
        messageForImage = false;
      });
    } else if (formstate.currentState!.validate()) {
      // postRequestWithFile not postRequest
      var response = await postRequestWithFile(
          linkAddjuices,
          {
            "name": nameController.text,
            "price": priceController.text,
            // ثابت ...مشوار نخلي المدير يدخل الوصف
            "description": "أفضل عصير في العالم",
            //ثابت تروح العصائر للمدير الاول الي هو عبدالله
            "id": 1
          },
          // مع تمرير الملف
          myFile!);

      if (response['status'] == "success") {
        print("==============  Added Successfuly");
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }
    } else {
      print("الصورة لم تتماشى مع الشروط");
      setState(() {
        messageForImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================================ App Bar ===================
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
      // =========================  Body  =======================
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              // ====================== حقل الادخال الاول  ===========
              CustomTextFormFiled(
                hint: "اسم المشروب",
                icon: const Icon(Icons.local_drink_rounded),
                myCcontroller: nameController,
                myValid: (val) {
                  return validInput(val!, 1, 15);
                },
                typeKeyword: TextInputType.name,
              ),
              const SizedBox(
                height: 10,
              ),
              // ====================== حقل الادخال الثاني  ===========
              CustomTextFormFiled(
                hint: "السعر",
                icon: const Icon(Icons.attach_money_rounded),
                myCcontroller: priceController,
                myValid: (val) {
                  return validInput(val!, 1, 3);
                },
                typeKeyword: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              // ================  زر اضافه الصورة مع المعرض==================
              MaterialButton(
                color:
                    isHereFile ? Colors.green.shade900 : Colors.green.shade200,
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
              // ================  زر اضافه الصورة ممن الكاميرا==================
              MaterialButton(
                color:
                    isHereFile ? Colors.green.shade900 : Colors.green.shade200,
                onPressed: () async {
                  // الكاميرا في المحاكي يعطينا خطأ
                  XFile? xfile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ===================== زر الاضافه  =====================
              MaterialButton(
                color: Colors.orange[800],
                onPressed: () async {
                  await addJuice();
                  if (messageForImage = false) {
                    setState(() {
                      messageForImage = true;
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "إضافة",
                    style: TextStyle(
                      // letterSpacing: 3,
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
    );
  }
}
