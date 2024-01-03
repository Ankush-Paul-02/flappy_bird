import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/utils/assets.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame flappyBirdGame;
  static const String id = 'gameOver';

  const GameOverScreen({
    Key? key,
    required this.flappyBirdGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${flappyBirdGame.bird.score}',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(Assets.gameOver),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Restart',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    flappyBirdGame.bird.reset();
    flappyBirdGame.overlays.remove('gameOver');
    flappyBirdGame.resumeEngine();
  }
}
