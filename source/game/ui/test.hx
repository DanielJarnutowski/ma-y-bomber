package game.ui;

import flixel.group.FlxSpriteGroup;

class HUD extends FlxSpriteGroup {
	var timeText:FlxText;
	var position:FlxPoint;

	public function new(x:Float, y:Float) {
		super();
		position = new FlxPoint(x, y);
		create();
	}

	function create() {
		createTime();
		this.members.iter((member) -> {
			member.scrollFactor.set(0, 0);
		});
	}

	function createHealth() {}

	function createScore() {
		scoreText = new FlxText(0, 12, -1, 'Score 000', Globals.FONT_SM);
		scoreText.screenCenterHorz();
		scoreText.x -= 20;
		add(scoreText);
	}

	function createTime() {
		timeText = new FlxText(0, 12, -1, 'Time 000', Globals.FONT_SM);
		timeText.x += 12;
		add(timeText);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
			updateHUD(elapsed);
		
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