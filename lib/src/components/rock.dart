import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../rocket_game.dart';
import 'components.dart';
import '../config.dart';

class Rock extends SpriteComponent with HasGameRef<RocketGame>, CollisionCallbacks {
    Rock({
        super.position,
    }) : super(size: Vector2.all(rockSize), anchor: Anchor.center);

    Future<void> onLoad() async {
        await super.onLoad();

        sprite = await gameRef.loadSprite('Rock.png');
        width = rockSize;
        height = rockSize;
        anchor = Anchor.center;

        add(RectangleHitbox());
    }

    @override
    void update(double dt) {
        super.update(dt);

        position.y += dt * 250;

        if (position.y > game.size.y) {
            removeFromParent();
        }
    }
}