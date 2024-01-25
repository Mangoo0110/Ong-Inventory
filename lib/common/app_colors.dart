import 'package:flutter/material.dart';

class AppColors {
  Color appActionColor () {
    return Colors.white;
  }
  Color appAccentColor () {
    return Colors.blueGrey;
  }

  Color appBackgroundColor () {
    return Colors.grey.shade300;
  }

  Color appForgroundColor ({
    required BuildContext context
  }) {
    return Colors.grey.shade200;
  }

  Color appTextColor () {
    return Colors.black87;
  }

  Color appGreenColor () {
    return Colors.green;
  }

  Color appTextColorGrey () {
    return Colors.grey.shade400;
  }

}
