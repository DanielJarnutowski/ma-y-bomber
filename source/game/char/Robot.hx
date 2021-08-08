package game.char;

class Robot extends BaseChar {
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
}