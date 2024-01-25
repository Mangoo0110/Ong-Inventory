import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_text_styles.dart';

typedef CallBack = void Function(String text);
class PriceTextfield extends StatelessWidget {
  final TextEditingController controller;
  CallBack onChanged;
  final String hintText;
  String labelText ;
  bool obscureText = false;
  int? maxLines = 1;
  PriceTextfield({
    Key? key,
    required this.maxLines,
    required this.obscureText,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.labelText,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TextFormField(
        maxLines: maxLines,
        controller: controller,
        obscureText: obscureText,
        style: AppTextStyle().normalSize(),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          //alignLabelWithHint: true,
          constraints: BoxConstraints(minHeight: constraints.maxHeight - 10),
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
          if(value ==null || value.isEmpty) {
            return "Price field can not be empty";
          }
          else if(double.tryParse(value) == null) {
            return "Not a valid price value. e.g. 10.7, 30, 22.2256 etc";
          }
          return null;
        },
      ),
    );
  }
}