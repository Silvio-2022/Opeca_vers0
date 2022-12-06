import 'package:flutter/material.dart';

class IndicadorProgressoCircularUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 115),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFF3b98d4)),
          ),
        ),
      ),
    );
  }
}
