package game.objects;

import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import game.char.Bomb;
import game.states.BaseLDTkState;

class Explosion extends FlxSliceSprite {
  public var defaultExplosionTimer = 3.0;
  public var presentExplosionTimer = 3.0;

  // public var explosionGroup: FlxTypedGroup<Explosion>;
  var explosion:Explosion;

  public function new(rect:FlxRect) {
    super(AssetPaths.bomb_explosion__png, rect, 4, 4);
    // explosion = super(AssetPaths.bomb_explosion__png, rect, 4, 4);
    // explosion =super(this.x,this.y);
    {}
    explosionGroup.add(this);

    if (presentExplosionTimer <= 0) {
      this.kill();
    }
  }
}