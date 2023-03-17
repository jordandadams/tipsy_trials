import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_defaults.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../models/intro.dart';
import '../../themes/text.dart';
import '../02_home/home.dart';

class IntroScreens extends StatefulWidget {
  const IntroScreens({Key? key}) : super(key: key);

  @override
  _IntroScreensState createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  // Add or remove intro from here
  List<Intro> _allIntros = [
    Intro(
      title: 'Welcome to Tipsy Trials!',
      imageLocation: AppImages.intro0,
      description:
          'Introducing the ultimate drinking card game where players can either perform fun challenges or take shots based on the cards drawn. Get ready to get tipsy and have a blast with your friends!',
    ),
    Intro(
      title: 'Play Locally or With Friends!',
      imageLocation: AppImages.intro1,
      description:
          'Choose to play Tipsy Trials locally with your friends on the same device, or select the multiplayer option and invite your friends to join in on the fun using the unique invite code.',
    ),
    Intro(
      title: 'A Game of Chance & Skill!',
      imageLocation: AppImages.intro2,
      description:
          'Tipsy Trials is a game that combines luck and skill as players draw cards and either perform challenges or take shots. With a variety of different cards to choose from, each round is sure to bring its own unique challenges and laughs.',
    ),
  ];

  /// Page Controller
  late PageController _pageController;

  /// Tracks currently active page
  RxInt _currentPage = 0.obs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _currentPage.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSizes.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* <---- Images And Title ----> */
              Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: _allIntros.length,
                    onPageChanged: (value) {
                      _currentPage.value = value;
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              _allIntros[index].imageLocation,
                            ),
                            Text(
                              _allIntros[index].title,
                              style: AppText.h6.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppSizes.hGap10,
                            Text(
                              _allIntros[index].description,
                              style: AppText.caption,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }),
              ),

              /* <---- Intro Dots ----> */
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _allIntros.length,
                    (index) => _IntroDots(
                      active: _currentPage.value == index,
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => HomeScreen());
                      },
                      child: Text('SKIP'),
                    ),
                    InkWell(
                      borderRadius: AppDefaults.defaulBorderRadius,
                      onTap: () {
                        if (_currentPage.value == _allIntros.length - 1) {
                          Get.to(() => HomeScreen());
                        } else {
                          _pageController.animateToPage(
                            _currentPage.value + 1,
                            duration: AppDefaults.defaultDuration,
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Obx(
                        () => Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: _currentPage.value == 2
                                ? BorderRadius.circular(30)
                                : BorderRadius.circular(100),
                          ),
                          child: _currentPage.value == 2
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Let's Play!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                )
                              : Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroDots extends StatelessWidget {
  const _IntroDots({
    Key? key,
    required this.active,
  }) : super(key: key);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDefaults.defaultDuration,
      width: 15,
      height: 15,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: active
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
