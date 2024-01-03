import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flappy_bird/game/game_configuration.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();
  late Bird bird;
  bool isHit = false;
  late TextComponent score;

  Timer interval = Timer(GameConfiguration.pipeInterval, repeat: true);

  @override
  FutureOr<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  TextComponent buildScore() {
    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'Game',
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
