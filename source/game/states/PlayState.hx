package game.states;

import flixel.addons.display.FlxSliceSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;
import game.ui.Hud;
import game.char.Bomb;
import game.objects.Explosion;
import game.char.Bomb;

class PlayState extends BaseLDTkState {
  // var explosiontwo:Explosion;
  public var collisionTimer = 1.0;

  override public function create() {
    super.create();
    createLevel(project.all_levels.Level_0);
    FlxG.sound.playMusic(AssetPaths.JDSherbert__Ma_y_Bomber_OST___Bomb_Field__ogg,
      true);
    // add(new FlxText("Hello World", 32).screenCenter());
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    hud.updateTime(gameTime);
    updateCollisions(elapsed);
  }

  public function updateCollisions(elapsed:Float) {
    FlxG.overlap(unbreakableGroup, playerGroup, playerTouchUnbreakable);
    FlxG.overlap(breakableGroup, playerGroup, playerTouchBreakable);
    FlxG.overlap(playerGroup, explosionGroup, playerTouchExplosion,
      playerExplosionCheck);
  }

  public function playerTouchUnbreakable(unbreakable:Unbreakable,
      player:BaseChar) {
    FlxObject.separate(unbreakable, player);
    player.resetPosition();
  }

  public function playerTouchBreakable(breakable:BreakableBlocks,
      player:BaseChar) {
    FlxObject.separate(breakable, player);
    player.resetPosition();
  }

  public function playerExplosionCheck(player:BaseChar,
      explosion:FlxSliceSprite) {
    return player.x.withinRangef(explosion.x, explosion.x + explosion.width)
      && player.y.withinRangef(explosion.y, explosion.y + explosion.height);
  }

  public function playerTouchExplosion(player:BaseChar,
      explosion:FlxSliceSprite) { // FlxObject.separate(explosion,player);
    // player.resetPosition();
    trace('Touched explosion in the game.', explosion.x, explosion.y,
      explosion.width, explosion.height);
    trace('Player Position', player.x, player.y);

    player.kill();
  }

  public function explosionTouchBreakable(explosion:Explosion,
      breakable:BreakableBlocks) {
    breakable.kill();
  }
}