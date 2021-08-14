package game.objects;

import flixel.FlxObject;

class BotAI extends FlxObject {
  public function idle(elapsed:Float) {}

  public function chase(elapsed:Float) {}

  public function attack(elapsed:Float) {}

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}