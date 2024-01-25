import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';

typedef SearchOnChangesCallBack = void Function(String text);
class SearchTextfield extends StatelessWidget {
  final TextEditingController controller;
  SearchOnChangesCallBack onChanged;
  final String hintText;
  bool obscureText = false;
  int? maxLines = 1;
  SearchTextfield({
    Key? key,
    required this.maxLines,
    required this.obscureText,
    required this.onChanged,
    required this.controller,
    required this.hintText,
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
          fillColor: Colors.blueGrey.shade300,
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            // borderSide: const BorderSide(
            //   color: Colors.black38,
            // ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: AppColors().appTextColor(),
                width: 2
              ),
          ),
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}