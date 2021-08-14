package game.char;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;

class Ninja extends BaseChar 
{
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
    loadGraphic(AssetPaths.ninja_character_player__png, true, 32, 32);
    animation.add('idle', [0],15);
    animation.add('walk_left', [9, 10, 11],15);
    animation.add('walk_down', [2, 3, 4],15);
    animation.add('walk_up', [6, 7, 8],15);
  }

  override public function setup() {
    setupCharacter();
    super.setup();
  }

  override public function updateMovement(elapsed:Float) {
    if (moveToNextTile) {
      switch (charDirection) {
        case Up:
          y -= Globals.MOVEMENT_SPEED;
          walking = true;
          direction = 'walk_up';
        case Down:
          y += Globals.MOVEMENT_SPEED;
          walking = true;
          direction= 'walk_down';
        case Left:
          facing = FlxObject.LEFT;
          walking = true;
          direction='walk_left';
          x -= Globals.MOVEMENT_SPEED;
        case Right:
          walking = true;
          facing = FlxObject.RIGHT;
          direction= 'walk_left';
          x += Globals.MOVEMENT_SPEED;
          default:
            walking = false;
      }

    }
    if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
      moveToNextTile = false;
      previousPosition = this.getPosition();
    }
  }
  function idle(elapsed:Float) {
     		animation.play('idle');
     		if (walking) {
     			state.currentState = moving;
     		}
     	}

        	function moving(elapsed:Float) {
		animation.play(direction);
		if (walking == false) {
		
			state.currentState = idle;
 		} 
     else {
 			
       state.currentState = moving;
 		}
 	}

   override public function update(elapsed:Float) {
     		super.update(elapsed);
     		state.update(elapsed);
         super.updateMovement(elapsed);
          super.playerMovement(controller);
          super.bound();
          super.updateBomb();
     	}
  

} 
