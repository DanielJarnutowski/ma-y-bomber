package game.states;

import game.objects.BombDown;
import groups.CollectibleGroup;
import game.objects.ExplosionDown;
import game.objects.SpeedDown;
import game.objects.SpeedUp;
import game.objects.BombDown;
import game.objects.BombUp;
import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;
import game.ui.Hud;
import game.char.Bomb;
import game.objects.Explosion;
import game.char.BaseChar;

class PlayState extends BaseLDTkState {
  public var hiddenItem:FlxSprite;
  public var itemX:Float;
  public var itemY:Float;
  public var collisionTimer = 1.0;
  public var currentState:game.GameTypes.PlayState;
  public var item:game.objects.Collectible;

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
    // Add in all the important information to the AI and base character
    // classes
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
    // Supply the current game state to all the characters
    playerGroup.forEachAlive((character) ->
      character.updateInternalState(playState));
  }

  public function updateCollisions(elapsed:Float) {
    FlxG.overlap(unbreakableGroup, playerGroup, playerTouchUnbreakable);
    FlxG.overlap(breakableGroup, playerGroup, playerTouchBreakable);
    FlxG.overlap(playerGroup, explosionGroup, playerTouchExplosion,
      playerExplosionCheck);
    FlxG.overlap(explosionGroup, breakableGroup, explosionTouchBreakable);
    // FlxG.overlap(playerGroup,collectibleGroup,playerTouchSpeedDown);
    // FlxG.overlap(playerGroup,collectibleGroup,playerTouchSpeedUp);
    // FlxG.overlap(playerGroup,collectibleGroup,playerTouchBombUp);
    // FlxG.overlap(playerGroup,collectibleGroup,playerTouchBombDown);
    FlxG.overlap(playerGroup, collectibleGroup, playerTouchItem);
    FlxG.overlap(collectibleGroup, explosionGroup, explosionTouchItem);
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
    var collectibles:Array<Dynamic> = [
       new BombUp(breakable.x,
        breakable.y), new SpeedDown(breakable.x, breakable.y),
      new SpeedUp(breakable.x,
        breakable.y),  new BombDown(breakable.x, breakable.y)
    ];
    item = collectibles[Math.floor(Math.random() * collectibles.length)];
    // item = new BombUp(breakable.x,breakable.y);
    hiddenItem = item;
    itemX = breakable.x;
    itemY = breakable.y;
    item.solid = false;
    item.visible = false;
    breakable.kill();
    collectibleGroup.add(item);
  }

  public function playerTouchItem(player:BaseChar, item:FlxSprite) {
    if (hiddenItem == new BombUp(itemX, itemY)) {
      if (player.bombCap < 8) {
        player.bombCap += 1;
      } else {
        player.bombCap = player.bombCap;
      }
    }

    if (hiddenItem == new BombDown(itemX, itemY)) {
      if (player.bombCap > 1) {
        player.bombCap -= 1;
      } else {
        player.bombCap = player.bombCap;
      }
    }

    if (hiddenItem == new SpeedUp(itemX, itemY)) {
      if (player.MOVEMENT_SPEED < 8.0) {
        player.MOVEMENT_SPEED = player.MOVEMENT_SPEED * 2;
      }
      else 
        {
          player.MOVEMENT_SPEED = player.MOVEMENT_SPEED ;
        }
    }

    if (hiddenItem == new SpeedDown(itemX, itemY)) {
      if (player.MOVEMENT_SPEED > 1.0) {
        player.MOVEMENT_SPEED = player.MOVEMENT_SPEED / 2;
      }
      else {
        player.MOVEMENT_SPEED = player.MOVEMENT_SPEED ;
      }
    }
    
    item.kill();
  }

  public function explosionTouchItem(item:FlxSprite,
      explosion:FlxSliceSprite) {
    item.kill();
  }
}