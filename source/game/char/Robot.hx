package game.char;

import openfl.display.Preloader.DefaultPreloader;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;

class Robot extends BaseChar {
  var state:State;
  var walking = false;
  var direction = 'idle';

  public function new(controller:PlayerType, x:Float, y:Float,
      explosionGroup) {
    super(controller, x, y, explosionGroup);
    setFacingFlip(FlxObject.LEFT, false, false);
    setFacingFlip(FlxObject.RIGHT, true, false);
    state = new State(idle);
  }

  public function setupCharacter() {
    loadGraphic(AssetPaths.robot_player_anim__png, true, 32, 32, true);
    animation.add('idle', [0], 15);
    animation.add('walk_down', [2, 1, 3], 15);
    animation.add('walk_up', [5, 4, 6], 15);
    animation.add('walk_left', [7, 8, 9], 15);
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

  function idle(elapsed:Float) {
    if (walking) {
      state.currentState = moving;
    } else {
      animation.play('idle');
    }
  }

  function moving(elapsed:Float) {
    animation.play(direction);
    if (walking == false) {
      state.currentState = idle;
    }
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    state.update(elapsed);
  }
}