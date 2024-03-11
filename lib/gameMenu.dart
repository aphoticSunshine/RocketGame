import 'package:flutter/material.dart';
import 'main.dart';

class GameMenu extends StatelessWidget {
    const GameMenu({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 60.0),
                            child: Text(
                                'Rocket Dash',
                                style: TextStyle(
                                    fontSize: 48,
                                    color: Colors.orange,
                                    shadows: [
                                        Shadow(
                                            blurRadius: 20.0,
                                            color: Colors.white,
                                            offset: Offset(0, 0),
                                        ),
                                    ],
                                ),
                            ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: ElevatedButton(
                                onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => const HomePage()),
                                    );
                                },
                                child: const Text('Lift-Off'),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}