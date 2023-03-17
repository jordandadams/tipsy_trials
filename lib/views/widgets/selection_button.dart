import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final RxBool isSelected;

  SelectionButton({
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ElevatedButton(
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected.value ? AppColors.primaryColor : Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: isSelected.value
              ? AppColors.accentColor
              : AppColors.primaryColor,
          side: BorderSide(
            color: isSelected.value ? AppColors.primaryColor : Colors.transparent,
          ),
        ),
      );
    });
  }
}