package game.char;
import openfl.display.Preloader.DefaultPreloader;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;

class Ninja extends BaseChar 
{
  var state:State;
  var walking = false;
  var direction = 'idle';
  public var timerOn = false;
  public var abilityTimer = 6.0;
  public var coolDown = 0.0;
  public var coolDownOn = false;
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
          facing = FlxObject.LEFT;
          walking = true;
          direction='walk_left';
          x -= MOVEMENT_SPEED;
        case Right:
          walking = true;
          facing = FlxObject.RIGHT;
          direction= 'walk_left';
          x += MOVEMENT_SPEED;
          
      }

    }
    
    if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
      moveToNextTile = false;
      previousPosition = this.getPosition();
      walking = false;
    }

  }

  override public function playerMovement(controller:PlayerType) {
    super.playerMovement(controller);
    if (controller == PlayerOne && FlxG.keys.pressed.N && coolDownOn == false )
      {
        timerOn = true;
        this.visible = false;
      }

      if (controller == PlayerTwo && FlxG.keys.pressed.W && coolDownOn == false)
        {
          timerOn = true;
          this.visible = false;
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

        if (timerOn == true)
          {
            abilityTimer = abilityTimer - elapsed;
          }

          if(abilityTimer <1.0)
            {
              timerOn = false;
              this.visible = true;
              coolDown = 31.0;
              coolDownOn = true;
              abilityTimer =6.0;
            }

            if (coolDownOn == true)
              {
                  coolDown = coolDown - elapsed;
              }

              if (coolDown <1.0)
                {
                  coolDownOn = false;
                }

          
      
     	}
  

} 





































