package game.ui;

import flixel.group.FlxSpriteGroup;

class HUD extends FlxSpriteGroup {
	var timeText:FlxText;
	var position:FlxPoint;
	var healthVisual:Array<FlxSprite>;
	var gameStartIndicator:Bool;

	public function new(x:Float, y:Float) {
		super();
		position = new FlxPoint(x, y);
		create();
	}

	function create() {
		createHealth();
		createTime();
		this.members.iter((member) -> {
			member.scrollFactor.set(0, 0);
		});
	}

	function createHealth() {}

	function createTime() {
		timeText = new FlxText(0, 12, -1, 'Time 180', Globals.FONT_SM);
		timeText.x -= 12;
		add(timeText);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (gameStartIndicator == true) {
			updateHUD(elapsed);
		}
	}

	function updateHUD(elapsed:Float) {
		updateTime(elapsed);
	}

	public function updateTime(time:Float) {
		var flooredTime = Math.floor(time);
		var time = '${flooredTime}'.lpad('0', 3);
		timeText.text = 'Time ${time}';
	}
}