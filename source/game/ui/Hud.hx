package game.ui;
import flixel.FlxCamera;
import flixel.util.FlxAxes;


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

	function createTime() {
		timeText = new FlxText(1, 12, -1, 'Time 180', Globals.FONT_SM);
		//timeText.x += 255;
		timeText.screenCenterHorz();
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