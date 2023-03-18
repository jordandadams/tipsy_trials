import 'package:flutter/material.dart';

class BouncingArrow extends StatefulWidget {
  const BouncingArrow({Key? key}) : super(key: key);

  @override
  _BouncingArrowState createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<BouncingArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _arrowController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -8, end: 8).animate(_arrowController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _arrowController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        );
      },
      child: Icon(
        Icons.arrow_forward,
        size: 18,
        ),
    );
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }
}