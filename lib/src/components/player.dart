import 'package:flame/components.dart';
import '../rocket_game.dart';

class Player extends SpriteComponent with HasGameRef<RocketGame> {
    late String shipName;

    Player({this.shipName = 'Spaceship.png'})
        : super(size: Vector2(100, 150), anchor: Anchor.center);

    @override
    Future<void> onLoad() async {
        await super.onLoad();

        sprite = await gameRef.loadSprite(shipName);
        position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
        final start = position;
        width = 60;
        height = 60;
        anchor = Anchor.center;
    }

    void move(Vector2 dt) {
        position.add(dt);
    }
}