import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Homepage.dart';

class splashscreen extends StatefulWidget {
  splashscreen({Key? key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacityanimation;
  late Animation<Offset> slideanimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      }
    });

    opacityanimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    slideanimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeScaleTransition(
        animation: opacityanimation,
        child: SlideTransition(
          position: slideanimation,
          child: Center(
            child: Image.asset(
              'assets/oie_bk7ja0DuRn8e.jpg',
              // color: Colors.white,
              // colorBlendMode: BlendMode.srcOver,
            ),
          ),
        ),
      ),
    );
  }
}
