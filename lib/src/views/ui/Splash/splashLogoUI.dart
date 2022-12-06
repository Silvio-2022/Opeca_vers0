import 'package:flutter/material.dart';

class SplashLogoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset(
          "assets/images/sop.png",
          scale: 0.9,
        ),
      ),
    );
  }
}
