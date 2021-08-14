package game.objects;

import lime.utils.Float64Array;
import openfl.Vector;
import js.html.webgl.VertexArrayObject;
import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import game.char.Bomb;

class ExplosionRight extends FlxSliceSprite {
  var cachedVertices:Vector<Float>;
  var bombangle:Float;
  var presentExplosionTimer = 3.0;

  public static inline var SIZE_OFFSET = 8;

  public function new(rect:FlxRect, x:Float, y:Float) {
    super(AssetPaths.bomb_explosion__png, rect, 4, 4);
    cachedVertices = this.vertices;
    bombangle = 0.degToRad();
    angle = bombangle;
    this.height = 32 - SIZE_OFFSET;
    this.width = 64 - SIZE_OFFSET;
    this.x = (x - (width - 128)) - (SIZE_OFFSET * 2);
    this.y = (y - (height - 64)) - (SIZE_OFFSET * 2);
    this.solid = false;

    trace('Create explosion right');
    trace('On explosion creation', this.x, this.y);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);

    if (cachedVertices.length == 0 && this.vertices != null
      && this.vertices.length > 0) {
      cachedVertices = this.vertices.copy();
      this.solid = true;
    }
    for (index in 0...cachedVertices.length) {
      if ((index + 1) % 2 == 0) {
        this.vertices[index] = cachedVertices[index - 1] * Math.sin(bombangle)
          + cachedVertices[index] * Math.cos(bombangle);
      } else {
        this.vertices[index] = cachedVertices[index] * Math.cos(bombangle)
          - cachedVertices[index + 1] * Math.sin(bombangle);
      }
    }

    if (presentExplosionTimer >= 0) {
      presentExplosionTimer = presentExplosionTimer - elapsed;
    }
    if (presentExplosionTimer <= 0) {
      this.kill();
    }
  }
}