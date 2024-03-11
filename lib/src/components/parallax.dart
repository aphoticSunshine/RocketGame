import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/parallax.dart';
import '../rocket_game.dart';

class BgParallax extends ParallaxComponent{
    @override
    Future<void> onLoad() async {
        parallax = await game.loadParallax([
            ParallaxImageData('StarsParallax.jpeg'),
            ParallaxImageData('AsteroidsParallax.png'),
        ], 
        baseVelocity: Vector2(0, -3),
        repeat: ImageRepeat.repeat,
        velocityMultiplierDelta: Vector2(0, 2.5));
    }
}