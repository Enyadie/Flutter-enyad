import 'package:flutter/material.dart';

class SSwingingImageAnimation extends StatefulWidget {
  final double? width;
  final ImageProvider image;

  const SSwingingImageAnimation({super.key, this.width, required this.image});

  @override
  __SwingingImageState createState() => __SwingingImageState();
}

class __SwingingImageState extends State<SSwingingImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: -0.100, end: 0.1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
      child: Image(
        image: widget.image,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
