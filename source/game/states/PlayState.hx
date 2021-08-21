package game.states;

import flixel.math.FlxRect;
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
  public var currentState:game.GameTypes.PlayState;

  override public function create() {
    super.create();
    createLevel(project.all_levels.Level_0);
    FlxG.sound.playMusic(AssetPaths.JDSherbert__Ma_y_Bomber_OST___Bomb_Field__ogg,
      true);
    currentState = null;
    // add(new FlxText("Hello World", 32).screenCenter());
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    hud.updateTime(gameTime);
    updateCollisions(elapsed);
  }

  override public function processLevel(elapsed:Float) {
    processDrawState();
    processWinState(elapsed);
    processPlayState(elapsed);
  }

  public function processDrawState() {
    drawMatch = (playerGroup.countLiving() < 1 || gameTime <= 0) && !winMatch;
    if (drawMatch) {
      // Process and Show draw on the screen with music for draw
    }
  }

  public function processWinState(elapsed:Float) {
    winMatch = playerGroup.countLiving() < 2;
    // Match is won when only one player is left
    if (winMatch) {
      // Process and show win on the screen with player number
    }
  }

  public function processPlayState(elapsed:Float) {
    var playState:game.GameTypes.PlayState = {
      playerOne: playerone,
      playerTwo: playertwo,
      playerThree: null,
      playerFour: null,
      collectibles: collectibleGroup,
      gameTime: gameTime,
      winGame: winMatch,
      drawGame: drawMatch,
      timeOutGame: drawMatch
    }
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

  public function explosionTouchBreakable(explosion:Explosion,
      breakable:BreakableBlocks) {
    breakable.kill();
  }
}