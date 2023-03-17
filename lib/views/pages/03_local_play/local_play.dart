import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../themes/text.dart';
import 'package:get/get.dart';

class LocalPlayScreen extends StatelessWidget {
  const LocalPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            children: [
              Text('Local Play Screen')
            ],
          ),
        ),
      ),
    );
  }
}