package game.objects;

import flixel.FlxObject;

class BotAI extends FlxObject {
  public var char:BaseChar;
  public var currentState:PlayState;
  public var state:State;

  public function new(character:BaseChar) {
    super(0, 0, 0, 0);
    char = character;
    state = new State(idle);
  }

  /**
   * Player will wander around the map moving in random
   * directions at given intervals.
   * @param elapsed 
   */
  public function idle(elapsed:Float) {
    var directionToMove = [Left, Right, Up, Down];
    var dir = directionToMove[FlxG.random.int(0, directionToMove.length - 1)];
    char.moveTo(dir);
  }

  /**
   * Player will chase after another player and try to bomb them.
   * @param elapsed 
   */
  public function chase(elapsed:Float) {}

  /**
   * Player will place a bomb down to inflict damage on someone.
   * @param elapsed 
   */
  public function attack(elapsed:Float) {}

  override public function update(elapsed:Float) {
    // Only process the ai state machine when we have state data
    if (currentState != null) {
      state.update(elapsed);
    }
    super.update(elapsed);
  }
}