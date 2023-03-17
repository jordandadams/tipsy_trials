import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isSelected;

  SelectionButton({
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(
            color: isSelected ? AppColors.primaryColor : Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: isSelected ? AppColors.accentColor : AppColors.primaryColor,
        side: BorderSide(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
      ),
    );
  }
}
