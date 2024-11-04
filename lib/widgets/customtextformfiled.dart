import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String hint;
  final TextInputType typeKeyword;
  final TextEditingController myCcontroller;
  final Icon icon;
  final String? Function(String?) myValid;
  const CustomTextFormFiled(
      {super.key,
      required this.hint,
      required this.icon,
      required this.myCcontroller,
      required this.myValid,
      required this.typeKeyword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: typeKeyword,
      textDirection: TextDirection.rtl,
      controller: myCcontroller,
      validator: myValid,
      cursorColor: Colors.orange,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          suffixIcon: icon,
          suffixIconColor: Colors.white70,

          // prefixIcon: icon,
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          hintStyle: const TextStyle(
            color: Colors.white24,
            fontSize: 20,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 3,
          )),
          // fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          ))),
    );
  }
}
