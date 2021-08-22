package game.states;

import groups.CollectibleGroup;
import game.objects.ExplosionDown;
import game.objects.SpeedDown;
import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;
import game.ui.Hud;
import game.char.Bomb;
import game.objects.Explosion;
import game.char.Bomb;
import game.char.BaseChar;


class PlayState extends BaseLDTkState {
public var speeditem:SpeedDown;
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
    FlxG.overlap(explosionGroup,breakableGroup,explosionTouchBreakable);
    FlxG.overlap(playerGroup,collectibleGroup,playerTouchCollectible);
    FlxG.overlap(collectibleGroup,explosionGroup,explosionTouchCollectible);
    
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
    var hitBox = player.getHitbox();
    return hitBox.overlaps(new FlxRect(explosion.x, explosion.y,
      explosion.width, explosion.height));
  }

  public function playerTouchExplosion(player:BaseChar,
      explosion:FlxSliceSprite) { // FlxObject.separate(explosion,player);
    // player.resetPosition();
    trace('Touched explosion in the game.', explosion.x, explosion.y,
      explosion.width, explosion.height);
    trace('Player Position', player.x, player.y);
    player.kill();
  }

  public function explosionTouchBreakable(explosion:FlxSliceSprite,
         breakable:BreakableBlocks) {
          speeditem = new SpeedDown(breakable.x,breakable.y);
          speeditem.solid = false;
          speeditem.visible = false;
          breakable.kill(); 
          collectibleGroup.add(speeditem);  
  }

  public function playerTouchCollectible(player:BaseChar,speeditem:SpeedDown) {
    speeditem.kill();
   if (player.MOVEMENT_SPEED >=1)
    {
      player.MOVEMENT_SPEED = player.MOVEMENT_SPEED /2;
    } 
  }

  public function explosionTouchCollectible(speeditem:SpeedDown,explosion:FlxSliceSprite) {
       speeditem.kill();  
  }

}