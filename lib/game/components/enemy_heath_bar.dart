import 'package:ball_bomber/app_constant.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HealthBar extends PositionComponent {
  double health;
  HealthBar(
      {required this.health,
      super.position,
      super.size,
      super.scale,
      super.anchor,
      super.children,
      super.priority});

  @override
  void render(Canvas canvas) {
    // Draws a rectangular health bar at top right corner.
    canvas.drawRect(
      Rect.fromLTWH(-2, 5, 5, (health * 15).toDouble()),
      Paint()..color = AppConstant.ENEMY_COLOR,
    );
    super.render(canvas);
  }
}
