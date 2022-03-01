package game.char;

// add cahnges for new bomb similar to kinos remote bomb stuff in robot class
import openfl.display.Preloader.DefaultPreloader;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;
import game.char.LightningBomb;

class Turtle extends BaseChar {
  var state:State;
  var walking = false;
  var direction = 'idle';

  // public var abilityTimerOn = false;
  // public var abilityTimer = 6.0;Z
  // public var coolDown = 0.0;
  // public var coolDownOn = false;

  public function new(controller:PlayerType, x:Float, y:Float,
      explosionGroup) {
    super(controller, x, y, explosionGroup);
    setFacingFlip(FlxObject.LEFT, false, false);
    setFacingFlip(FlxObject.RIGHT, true, false);
    state = new State(idle);
  }

  public function setupCharacter() {
    loadGraphic(AssetPaths.turtle_character_player__png, true, 32, 32);
    animation.add('idle', [0], 15);
    animation.add('walk_left', [9, 10, 11], 15);
    animation.add('walk_down', [2, 3, 4], 15);
    animation.add('walk_up', [6, 7, 8], 15);
  }

  override public function setup() {
    setupCharacter();
    super.setup();
  }

  override public function updateMovement(elapsed:Float) {
    if (moveToNextTile) {
      switch (charDirection) {
        case Up:
          y -= MOVEMENT_SPEED;
          walking = true;
          direction = 'walk_up';
        case Down:
          y += MOVEMENT_SPEED;
          walking = true;
          direction = 'walk_down';
        case Left:
          facing = FlxObject.LEFT;
          walking = true;
          direction = 'walk_left';
          x -= MOVEMENT_SPEED;
        case Right:
          walking = true;
          facing = FlxObject.RIGHT;
          direction = 'walk_left';
          x += MOVEMENT_SPEED;
      }
    }

    if (totalMoveAmount > Globals.TILE_SIZE || (x % Globals.TILE_SIZE == 0)
      && (y % Globals.TILE_SIZE == 0)) {
      if (charDirection != null && totalMoveAmount > Globals.TILE_SIZE) {
        var diff = totalMoveAmount % Globals.TILE_SIZE;

        switch (charDirection) {
          case Up:
            y += diff;

          case Down:
            y -= diff;

          case Left:
            x += diff;

          case Right:
            x -= diff;
        }
      }
      totalMoveAmount = 0;
      moveToNextTile = false;
      previousPosition = this.getPosition();
      walking = false;
    }
  }

  override public function playerMovement(controller:PlayerType) {
    super.playerMovement(controller);
    if (controller == PlayerOne && FlxG.keys.pressed.N) {
      placeLightningBomb(this.x - this.offset.x, this.y - this.offset.y);
    }

    if (controller == PlayerTwo && FlxG.keys.pressed.W) {
      placeLightningBomb(this.x - this.offset.x, this.y - this.offset.y);
    }
  }

  function idle(elapsed:Float) {
    if (walking) {
      state.currentState = moving;
    } else {
      animation.play('idle');
    }
  }

  function moving(elapsed:Float) {
    animation.play(direction);

    if (skullActive == true) {
      animation.play('idle');
    }
    if (walking == false) {
      state.currentState = idle;
    }
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    state.update(elapsed);
  }

  public function placeLightningBomb(x:Float, y:Float) {
    var bomb = new LightningBomb(x, y, explosionGroup);
    bomb.presentBombTimer = 1.0;
    bombGroup.add(bomb);
    bombDropSound.play(true);
  }

}