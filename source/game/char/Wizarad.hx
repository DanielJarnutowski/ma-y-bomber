package game.char;

class Wizard extends BaseChar {
	public function new(controller:PlayerType, x:Float, y:Float) {
		super(controller, x, y);
		setupCharacter();
	}

	public function setupCharacter() {
		loadGraphic(AssetPaths.wizard_player_anim__png, true, 32, 32, true);
		animation.add('idle', [0, 1]);
		animation.add('walk_down', [0, 1, 2]);
		animation.add('walk_up', [3, 4, 5]);
		animation.add('walk_right', [6, 7, 8]);
	}
}