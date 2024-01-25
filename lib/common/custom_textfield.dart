import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';

typedef CallBack = void Function(String text);
typedef ValidateCallBack = String? Function(String text);
class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  CallBack onChanged;
  ValidateCallBack onValidate;
  final String hintText;
  String labelText ;
  bool obscureText = false;
  int? maxLines = 1;
  CustomTextfield({
    Key? key,
    required this.maxLines,
    required this.obscureText,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.onValidate,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TextFormField(
        maxLines: maxLines,
        controller: controller,
        obscureText: obscureText,
        style: AppTextStyle().normalSize(),
        decoration: InputDecoration(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          hintText: hintText,
          label: Text(labelText),
          labelStyle: AppTextStyle().normalSize(),
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 2
              ),
          ),
        ),
        onChanged: (value) {
          onChanged(value);
          
        },
        validator: (value) {
          return onValidate(value!);
        },
      ),
    );
  }
}