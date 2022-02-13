package game.states;

import game.ui.TextButton;

class PauseSubState extends FlxSubState {
	public var pauseText:FlxText;

	private var pauseExitSound:FlxSound;
	private var initialPosition:Float;
	private var timeCount:Float;
	public var lobby:LobbySettingsSubState;

	public function new(lobby:LobbySettingsSubState){ 
		super(KColor.RICH_BLACK_FORGRA_LOW); // Lower Opacity RICH_Black
		super();
		this.lobby = lobby;
	  }

	override public function create() {
		pauseExitSound = FlxG.sound.load(AssetPaths.pause_out__wav);
		FlxG.mouse.visible = true;
		pauseText = new FlxText(0, 0, -1, 'Pause', Globals.FONT_L);
		pauseText.screenCenter();
		pauseText.y -= 120;
		pauseText.scrollFactor.set(0, 0);
		initialPosition = pauseText.y;
		add(pauseText);
		var resumeButton = new TextButton(0, 0, 'Resume', Globals.FONT_N,
			resumeGame);
		resumeButton.screenCenter();
		resumeButton.y -= 60;
		resumeButton.hoverColor = KColor.BURGUNDY;
		resumeButton.clickColor = KColor.BURGUNDY;
		var returnToTitleButton = new TextButton(0, 0, 'Title',
			Globals.FONT_N, toTitle);
		returnToTitleButton.screenCenter();
		returnToTitleButton.y += 60;
		returnToTitleButton.hoverColor = KColor.BURGUNDY;
		returnToTitleButton.clickColor = KColor.BURGUNDY;
		var lobbyButton = new TextButton(0, 0, 'Lobby',
			Globals.FONT_N, toLobby);
			lobbyButton.screenCenter();
			lobbyButton.y -= 20;
			lobbyButton.hoverColor = KColor.BURGUNDY;
			lobbyButton.clickColor = KColor.BURGUNDY;
		var charSelectButton = new TextButton(0, 0, 'Character Select',
			Globals.FONT_N, toCharSelect);
			charSelectButton.screenCenter();
			charSelectButton.y += 20;
			charSelectButton.hoverColor = KColor.BURGUNDY;
			charSelectButton.clickColor = KColor.BURGUNDY;
		add(lobbyButton);
		add(charSelectButton);
		add(resumeButton);
		add(returnToTitleButton);
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePausePosition(elapsed);
	}

	public function updatePausePosition(elapsed:Float) {
		timeCount += elapsed;
		pauseText.y = initialPosition + (30 * Math.sin(timeCount));
		if (timeCount > 30) {
			timeCount = 0;
		}
	}

	public function resumeGame() {
		pauseExitSound.play();
		close();
	}

	public function toTitle() {
		pauseExitSound.play();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			//FlxG.sound.pause();
			FlxG.sound.destroy();
			FlxG.switchState(new TitleState());
		});
	}

	public function toCharSelect() {
		pauseExitSound.play();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			//FlxG.sound.pause();
			FlxG.sound.destroy();
			FlxG.switchState(new PlayerOneSelectSubState(lobby));
		});
	}

	public function toLobby() {
		pauseExitSound.play();
		FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
			close();
			//FlxG.sound.pause();
			FlxG.sound.destroy();
			FlxG.switchState(new LobbySettingsSubState());
		});
	}


}