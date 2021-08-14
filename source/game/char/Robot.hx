package game.char;
import flixel.FlxObject;
import flixel.FlxSprite;
import game.State;

class Robot extends BaseChar {
  public var currentState:Float -> Void;
  public var initialState:Float -> Void;
  public var walkingState:Float -> Void;
  public function new(controller:PlayerType, x:Float, y:Float,
      explosionGroup) {
    super(controller, x, y, explosionGroup);
    setupCharacter();
  }

  public function setupCharacter() {
    loadGraphic(AssetPaths.robot_player_anim__png, true, 32, 32, true);
    animation.add('idle', [0]);
    animation.add('walk_down', [2, 1, 3]);
    animation.add('walk_up', [5, 4, 6]);
    animation.add('walk_left', [7, 8, 9]);
   
  }

  override public function updateMovement(elapsed:Float) {
    if (moveToNextTile) {
      switch (charDirection) {
        case Up:
          y -= Globals.MOVEMENT_SPEED;
          currentState = walkingState;
          animation.play('walk_up');
        case Down:
          y += Globals.MOVEMENT_SPEED;
          currentState = walkingState;
          animation.play('walk_down');
        case Left:
          facing = FlxObject.LEFT;
          x -= Globals.MOVEMENT_SPEED;
          currentState = walkingState;
          animation.play('walk_left');
        case Right:
          facing = FlxObject.RIGHT;
          x += Globals.MOVEMENT_SPEED;
          currentState = walkingState;
          animation.play('walk_left');
      }

    }
    if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
      moveToNextTile = false;
      previousPosition = this.getPosition();
    }
  }
}