import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/game_configuration.dart';
import 'package:flappy_bird/game/pipe_position.dart';
import 'package:flappy_bird/utils/assets.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  @override
  final double height;
  final PipePosition pipePosition;

  Pipe({
    required this.height,
    required this.pipePosition,
  });

  @override
  FutureOr<void> onLoad() async {
    final pipe = await Flame.images.load(Assets.pipe);
    final pipeRotated = await Flame.images.load(Assets.pipeRotated);

    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.down:
        position.y = gameRef.size.y - size.y - GameConfiguration.groundHeight;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}
