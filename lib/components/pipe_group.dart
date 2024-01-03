import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/game_configuration.dart';
import 'package:flappy_bird/game/pipe_position.dart';
import 'package:flappy_bird/utils/assets.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  final _random = Random();

  @override
  FutureOr<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - GameConfiguration.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing;

    addAll([
      Pipe(
        height: centerY - spacing / 2,
        pipePosition: PipePosition.top,
      ),
      Pipe(
        height: heightMinusGround - (centerY + spacing / 2),
        pipePosition: PipePosition.down,
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= GameConfiguration.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score++;
    FlameAudio.play(Assets.point);
  }
}
