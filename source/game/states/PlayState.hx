package game.states;

// change collisions for collectibles or explosion class or collectibles
// to fix so they dont get destroyed when not in contact
import game.objects.Collectible;
import game.objects.BombDown;
import groups.CollectibleGroup;
import game.objects.ExplosionDown;
import game.objects.SpeedDown;
import game.objects.SpeedUp;
import game.objects.BombDown;
import game.objects.BombUp;
import game.objects.Skull;
import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;
import game.ui.Hud;
import game.char.Bomb;
import game.objects.Explosion;
import game.char.BaseChar;
import flixel.FlxSprite;
import game.char.DeathAnimation;

class PlayState extends BaseLDTkState {
  public var hiddenItem:FlxSprite;
  public var deathTimer = 4.0;
  public var deathOn = false;
  //public var collisionTimer = 1.0;
  public var currentState:game.GameTypes.PlayState;

  // public var item:game.objects.Collectible;

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
    if (deathOn ==true)
      {
        deathTimer = deathTimer - elapsed;
      }

      if (deathTimer <=1.0)
        {// edit this gameover screen later
          FlxG.switchState(new GameOverSubState());
        }
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
    // FlxG.overlap(playerOneBombGroup, playerGroup, playerTouchBomb);
    FlxG.overlap(breakableGroup, playerGroup, playerTouchBreakable);
    FlxG.overlap(playerGroup, explosionGroup, playerTouchExplosion,
      playerExplosionCheck);
    FlxG.overlap(explosionGroup, breakableGroup, explosionTouchBreakable);
    FlxG.overlap(playerGroup, collectibleGroup, playerTouchItem);
    FlxG.overlap(collectibleGroup, explosionGroup, explosionTouchItem,
      explosionTouchItemCheck);
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
    // player dies, remember to add some animation for this. sprite already made for this just figure out how to add
    //
    var death = new DeathAnimation(player.x, player.y);
    add(death);
    if (player.invincibility == false) {
      deathOn=true;
      player.kill();
     death.playDeath(player.x, player.y);
    }
  }

  public function explosionTouchBreakable(explosion:FlxSliceSprite,
      breakable:BreakableBlocks) {
    var collectibles:Array<Dynamic> = [
      // new BombUp(breakable.x,breakable.y),
      new SpeedDown(breakable.x, breakable.y),
      new SpeedUp(breakable.x, breakable.y),
      // new BombDown(breakable.x, breakable.y),
      // new Skull(breakable.x, breakable.y)

    ];
    hiddenItem = collectibles[Math.floor(Math.random() * collectibles.length)];
    // hiddenItem = item;
    hiddenItem.x = breakable.x;
    hiddenItem.y = breakable.y;
    hiddenItem.solid = false;
    hiddenItem.visible = false;
    breakable.kill();
    collectibleGroup.add(hiddenItem);
  }

  public function playerTouchItem(player:BaseChar, item:Collectible) {
    switch (Type.getClass(item)) {
      case SpeedUp:
        if (player.MOVEMENT_SPEED < 8.0) {
          player.MOVEMENT_SPEED = player.MOVEMENT_SPEED * 2;
        } else {
          player.MOVEMENT_SPEED = player.MOVEMENT_SPEED;
        }
      case SpeedDown:
        if (player.MOVEMENT_SPEED > 1.0) {
          player.MOVEMENT_SPEED = player.MOVEMENT_SPEED / 2;
        } else {
          player.MOVEMENT_SPEED = player.MOVEMENT_SPEED;
        }
      case BombUp:
        if (player.bombCap < 8) {
          player.bombCap += 1;
        } else {
          player.bombCap = player.bombCap;
        }
      case BombDown:
        if (player.bombCap > 1) {
          player.bombCap -= 1;
        } else {
          player.bombCap = player.bombCap;
        }
      case Skull:
        player.tempBombCap = player.bombCap;

        if (player.tempBombCap == player.bombCap) {
          player.skullActive = true;
          player.bombCap = 0;
          player.MOVEMENT_SPEED = 0;
        }

      case _:
        // Do nothing
    }
    item.kill();
  }

  public function explosionTouchItem(item:FlxSprite,
      explosion:FlxSliceSprite) {
    item.kill();
  }

  public function explosionTouchItemCheck(item:FlxSprite,
      explosion:FlxSliceSprite) {
    var hitBox = item.getHitbox();
    return hitBox.overlaps(new FlxRect(explosion.x, explosion.y,
      explosion.width, explosion.height));
  }
}