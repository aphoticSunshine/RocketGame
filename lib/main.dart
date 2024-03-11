import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'src/rocket_game.dart';
import 'gameOverScreen.dart';

void main() async {   
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData.dark(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  State<HomePage> createState() => _HomePageState(); 
}

class _HomePageState extends State<HomePage> {
  late RocketGame _rocketGame;

  @override
  void initState() {
    _rocketGame = RocketGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GameWidget(
              game: _rocketGame,
              overlayBuilderMap: {
                GameOverScreen.id: (_, __) => GameOverScreen(game: _rocketGame),
              },
              initialActiveOverlays: const [],
            ),
          ),
          if (_rocketGame.isGamePlaying)
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rocketGame.pauseGame();
                      });
                    },
                    icon: Icon(Icons.pause),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _rocketGame.current_score,
                    builder: (context, int value, child) {
                      return Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 245),
                  ValueListenableBuilder(
                    valueListenable: _rocketGame.health,
                    builder: (context, int value, child) {
                      return Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          if (_rocketGame.isGameOver && !_rocketGame.isGamePaused)
            Container(
              color: Colors.black45,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'G A M E  O V E R !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _rocketGame.resetGame();
                          });
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 140,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        if (_rocketGame.isGamePaused && !_rocketGame.isGameOver)
          Container(
            color: Colors.black45,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'P A U S E D',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _rocketGame.resumeGame();
                        });
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 140,                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}