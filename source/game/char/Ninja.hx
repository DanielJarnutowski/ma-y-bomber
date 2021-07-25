package game.char;

class Ninja extends BaseChar {
	public function new(controller:PlayerType, x:Float, y:Float) {
		super(controller, x, y);
		setupCharacter();
	}

	public function setupCharacter() {
		loadGraphic(AssetPaths.ninja_character_player__png, true, 32, 32);
		animation.add('idle', [0]);
		animation.add('walk_left', [9, 10, 11]);
		animation.add('walk_down', [2, 3, 4]);
		animation.add('walk_up', [6, 7, 8]);
	}
}