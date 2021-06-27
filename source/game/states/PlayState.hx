package game.states;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends BaseLDTkState {
	public var player:BaseChar;

	override public function create() {
		super.create();
		createLevel(project.all_levels.Level_0);
		createChar();
		createChar();
		
		//add(new FlxText("Hello World", 32).screenCenter());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateCollisions(elapsed);
	}

	public function createChar()
        {
            var player = new BaseChar(PlayerOne,32,32);
			var playerTwo = new BaseChar(PlayerTwo,64,64);
			player.loadGraphic(AssetPaths.turtle_character_player__png,false,32,32,false);
			playerTwo.loadGraphic(AssetPaths.ninja_character_player__png,false,64,64,false);
			add(playerTwo);
			add(player);
        }
		public function updateCollisions(elapsed:Float)
			{
			FlxG.overlap(unbreakableGroup,playerGroup,playerTouchUnbreakable);	
			}

			public function playerTouchUnbreakable (unbreakable,BaseChar )
			{
				FlxObject.separate(unbreakable,player);
						player.resetPosition();
					
			}
		

		


}