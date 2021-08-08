package game.char;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;

class Ninja extends BaseChar 
{
  public var currentState:Float -> Void;
  public var initialState:Float -> Void;
  public function new(controller:PlayerType, x:Float, y:Float,
      explosionGroup) {
    super(controller, x, y, explosionGroup);
   setFacingFlip(FlxObject.LEFT, false, false);
   setFacingFlip(FlxObject.RIGHT, true, false);

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
          currentState = null;
          animation.play('walk_up');
        case Down:
          y += Globals.MOVEMENT_SPEED;
          currentState = null;
          animation.play('walk_down');
        case Left:
          facing = FlxObject.LEFT;
          x -= Globals.MOVEMENT_SPEED;
          currentState = null;
          animation.play('walk_left');
        case Right:
          facing = FlxObject.RIGHT;
          x += Globals.MOVEMENT_SPEED;
          currentState = null;
          animation.play('walk_left');
      }

    }
    if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
      moveToNextTile = false;
      previousPosition = this.getPosition();
    }
  }
  override public function playerMovement(controller:PlayerType) {
    super.playerMovement(controller);
    if (controller == PlayerTwo) {
      
      if (FlxG.keys.released.ANY && !FlxG.keys.pressed.ANY) {
       currentState = null;
       if(currentState==initialState)
        {
          animation.play('idle');
        }
        
      }   
      else if (FlxG.keys.pressed.ANY && !FlxG.keys.pressed.Q)
        {
          currentState = null;
        }
    }
  }

} 