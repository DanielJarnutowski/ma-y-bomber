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
  public var abilityTimerOn = false;
  public var abilityTimer = 16.0;
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
  loadGraphic(AssetPaths.wizard_player_anim__png, true, 32, 32, true);
  animation.add('idle', [0],15);
  animation.add('walk_down', [0, 1, 2],15);
  animation.add('walk_up', [3, 4, 5],15);
  animation.add('walk_right', [6, 7, 8],15);
  animation.add('invincible-idle',[18,19],15);
  animation.add('invincible-down',[9,10,11],15);
  animation.add('invincible-up',[12,13,14],15);
  animation.add('invincible-right',[15,16,17],15);
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
          direction='walk_right';
          x -= MOVEMENT_SPEED;
        case Right:
          walking = true;
          facing = FlxObject.RIGHT;
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
           if(abilityTimerOn==true)
            {
              animation.play('invincible-idle');
            }
            else{
              animation.play('idle');
            }
         }
     	}

  function moving(elapsed:Float) {
    if (abilityTimerOn == true) {
      if (direction == 'walk_up') {
        animation.play('invincible-up');
      }
      else if (direction == 'walk_down') {
        animation.play('invincible-down');
      }
      else if (direction == 'walk_right') {
        animation.play('invincible-right');
      }
      else if (direction == 'walk_right') {
        animation.play('invincible-right');
      }
              }
              else{
            animation.play(direction);  
                   }
		if (walking == false) {
			state.currentState = idle;
 		} 
     
     
 	}

   override public function playerMovement(controller:PlayerType) {
    super.playerMovement(controller);
    if (controller == PlayerOne && FlxG.keys.pressed.N && coolDownOn == false )
      {
        abilityTimerOn = true;
        invincibility = true;
        
      }

      if (controller == PlayerTwo && FlxG.keys.pressed.W && coolDownOn == false)
        {
          abilityTimerOn = true;
          invincibility = true;
        }
  }

   override public function update(elapsed:Float) {
     		super.update(elapsed);
     		state.update(elapsed);
        //make if statements for this here copy ninja class make similar
        if (abilityTimerOn == true)
          {
            abilityTimer = abilityTimer - elapsed;
           
          }

          if(abilityTimer <1.0)
            {
              abilityTimerOn = false;
              invincibility = false;
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










