import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget buildLoadingState(BuildContext context) {
  final color = Theme.of(context).colorScheme;

  return Scaffold(
    body: Center(
      child: LoadingAnimationWidget.dotsTriangle(color: color.primary, size: 40),
    ),
  );
}
