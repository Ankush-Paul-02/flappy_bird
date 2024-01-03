import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/game_configuration.dart';
import 'package:flappy_bird/utils/assets.dart';

class Ground extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  Ground();

  @override
  FutureOr<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      )
    ]);

    add(RectangleHitbox(
      position: Vector2(
        0,
        gameRef.size.y - GameConfiguration.groundHeight,
      ),
      size: Vector2(gameRef.size.x, GameConfiguration.groundHeight),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = GameConfiguration.gameSpeed;
  }
}
