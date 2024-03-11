import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'components/components.dart';
import '../gameOverScreen.dart';
import 'config.dart';
import 'package:flame_audio/flame_audio.dart';

class RocketGame extends FlameGame with PanDetector, HasCollisionDetection{
    late final player;
    ValueNotifier<int> current_score = ValueNotifier(0);
    ValueNotifier<int> health = ValueNotifier(30);
    bool gameFin = false;
    bool _gamePaused = false;
    Vector2 startingPosition = Vector2(196.3636363637, 707.272727273);

    @override
    FutureOr<void> onLoad() async {
        add(BgParallax());
        player = Player();
        add(player);
        add(
            SpawnComponent(
                factory: (index) {
                    return Rock();
                },
                period: .75,
                area: Rectangle.fromLTWH(0, 0, size.x, -rockSize),
            ),
        );
        FlameAudio.bgm.initialize();
        FlameAudio.bgm.play('spaceMusic.mp3');
    }

    @override
    void onPanUpdate(DragUpdateInfo info) {
        player.move(info.delta.global);
    }

    @override
    void update(double dt) {
        super.update(dt);
        if (!gameFin) {
            for (final rock in children.whereType<Rock>()) {
                if (player.toRect().overlaps(rock.toRect())) {
                    decreaseHealth();
                    if(health.value == 0){
                        gameOver();
                        break;
                    }
                }
                else {
                    increaseScore();
                }
            }
        }
    }

    void gameOver() {
        gameFin = true;
        FlameAudio.bgm.pause();
        FlameAudio.play('gameOverEffect.wav');
        pauseEngine();
        overlays.add(GameOverScreen.id);
    }

    void resetGame() {
        gameFin = false;
        current_score.value = 0;
        health.value = 30;
        children.whereType<Rock>().forEach(remove);
        resumeEngine();
        player.position = startingPosition;
        overlays.remove(GameOverScreen.id);
    }

    bool get isGameOver => gameFin;
    bool get isGamePaused => paused;
    bool get isGamePlaying => !isGamePaused;

    void pauseGame() {
        pauseEngine();
    }

    void resumeGame() {
        resumeEngine();
    }

    void increaseScore() {
        current_score.value++;
    }

    void decreaseHealth() {
        health.value--;
    }
}