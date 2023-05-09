import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Green3DButton extends StatelessWidget {
  final VoidCallback onPressed;

  Green3DButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 8,
        intensity: 0.6,
        lightSource: LightSource.topLeft,
        color: Colors.green,
      ),
      child: Container(
        width: 60,
        height: 60,
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
