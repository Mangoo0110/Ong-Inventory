import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';

class AppTextStyle {
  TextStyle boldNormalSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 16, fontWeight: FontWeight.bold);
  }

  TextStyle boldGreenNormalSize() {
    return TextStyle(color: AppColors().appGreenColor(), fontSize: 16, fontWeight: FontWeight.bold);
  }

  TextStyle boldActionNormalSize() {
    return TextStyle(color: AppColors().appActionColor(), fontSize: 16, fontWeight: FontWeight.bold);
  }

  TextStyle boldBigSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 20, fontWeight: FontWeight.bold);
  }

  TextStyle boldGreyBigSize() {
    return TextStyle(color: AppColors().appTextColorGrey(), fontSize: 20, fontWeight: FontWeight.bold);
  }

  TextStyle normalSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 16);
  }
  TextStyle actionNormalSize() {
    return TextStyle(color: AppColors().appActionColor(), fontSize: 16);
  }
  TextStyle normalGreySize() {
    return TextStyle(color: AppColors().appTextColorGrey(), fontSize: 16);
  }

  TextStyle boldGreenSmallSize() {
    return TextStyle(color: AppColors().appGreenColor(), fontSize: 12, fontWeight: FontWeight.bold);
  }

  TextStyle boldSmallSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 12, fontWeight: FontWeight.bold);
  }

  TextStyle boldSmallSizeGrey() {
    return TextStyle(color: AppColors().appTextColorGrey(), fontSize: 12, fontWeight: FontWeight.bold);
  }
  TextStyle smallSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 12,);
  }

  TextStyle extraSmallSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 10, fontStyle: FontStyle.italic);
  }

  TextStyle redSmallSize() {
    return TextStyle(color: AppColors().appTextColor(), fontSize: 12,);
  }

  TextStyle smallSizeGrey() {
    return TextStyle(color: AppColors().appTextColorGrey(), fontSize: 12,);
  }
}
