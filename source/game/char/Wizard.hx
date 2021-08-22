package game.char;
import openfl.display.Preloader.DefaultPreloader;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;

class Wizard extends BaseChar 
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
  loadGraphic(AssetPaths.wizard_player_anim__png, true, 32, 32, true);
  animation.add('idle', [0]);
  animation.add('walk_down', [0, 1, 2]);
  animation.add('walk_up', [3, 4, 5]);
  animation.add('walk_right', [6, 7, 8]);
}
  override public function setup() {
    setupCharacter();
    super.setup();
  }

  override public function updateMovement(elapsed:Float) {
    if (moveToNextTile) 
      {
      switch (charDirection) {
        case Up:
          y -= MOVEMENT_SPEED;
          walking = true;
          direction = 'walk_up';
        case Down:
          y += MOVEMENT_SPEED;
          walking = true;
          direction= 'walk_down';
        case Left:
          facing = FlxObject.RIGHT;
          walking = true;
          direction='walk_right';
          x -= MOVEMENT_SPEED;
        case Right:
          walking = true;
          facing = FlxObject.LEFT;
          direction= 'walk_right';
          x +=MOVEMENT_SPEED;
          
      }

    }
    
    if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
      moveToNextTile = false;
      previousPosition = this.getPosition();
      walking = false;
    }

    
  }
  function idle(elapsed:Float) {
    
     		if (walking) {
     			state.currentState = moving;
           
     		}
         else {
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










