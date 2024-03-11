import 'package:flutter/material.dart';
import 'gameMenu.dart';
import 'src/rocket_game.dart';

class GameOverScreen extends StatelessWidget {
    static const String id = 'GameOverScreen';
    final RocketGame game;

    const GameOverScreen({Key? key, required this.game}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Center(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.0),
                        child: Text(
                            'G A M E  O V E R',
                            style: TextStyle(
                                fontSize: 52,
                                color: Colors.orange,
                                shadows: [
                                    Shadow(
                                        blurRadius: 20.0,
                                        color: Colors.white,
                                        offset: Offset(2, 1),
                                    ),
                                ],
                            ),
                        ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                            onPressed: () {
                                game.overlays.remove(GameOverScreen.id);
                                game.resetGame();
                                game.resumeEngine();
                            },
                            child: const Text('Restart?')
                        ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                            onPressed: () {
                                game.overlays.remove(GameOverScreen.id);
                                game.resetGame();
                                game.resumeEngine();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => const GameMenu()),
                                );
                            },
                            child: const Text('Exit'),
                        ),
                    ),
                ], 
            ),
        );
    }
}