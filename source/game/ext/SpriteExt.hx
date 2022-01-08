package game.ext;

import flixel.FlxCamera;
import flixel.util.FlxAxes;

class SpriteExt {
  public static inline function screenCenterHorz(sprite:FlxSprite) {
    sprite.screenCenter(FlxAxes.X);
  }

  public static inline function cameraCenter(sprite:FlxSprite,
      ?camera:FlxCamera) {
    camera = camera == null ? sprite.camera : camera;
    sprite.cameraCenterHorz(camera);
    sprite.cameraCenterVert(camera);
  }

  public static inline function cameraCenterHorz(sprite:FlxSprite,
      ?camera:FlxCamera) {
    camera = camera == null ? sprite.camera : camera;
    sprite.x = ((camera.x + camera.width) / 2) - (sprite.width / 2);
  }

  public static inline function screenCenterVert(sprite:FlxSprite) {
    sprite.screenCenter(FlxAxes.Y);
  }

  public static inline function cameraCenterVert(sprite:FlxSprite,
      ?camera:FlxCamera) {
    camera = camera == null ? sprite.camera : camera;
    sprite.y = ((camera.y + camera.height) / 2) - (sprite.height / 2);
  }

  public static inline function drawBorder(sprite:FlxSprite, size:Float,
      color:FlxColor) {
    sprite.drawRect(0, 0, sprite.width, sprite.height, KColor.TRANSPARENT, {
      thickness: size,
      color: color,
    });
  }
}