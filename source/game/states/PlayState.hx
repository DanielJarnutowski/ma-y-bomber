package game.states;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;
import game.ui.Hud;
import game.char.Bomb;

class PlayState extends BaseLDTkState {
	

	

	override public function create() {
		super.create();
		createLevel(project.all_levels.Level_0);
		
		FlxG.sound.playMusic(AssetPaths.JDSherbert__Ma_y_Bomber_OST___Bomb_Field__ogg,true);
		//add(new FlxText("Hello World", 32).screenCenter());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateCollisions(elapsed);
	}

	
		public function updateCollisions(elapsed:Float)
			{
			FlxG.overlap(unbreakableGroup,playerGroup,playerTouchUnbreakable);	
			FlxG.overlap(breakableGroup,playerGroup,playerTouchBreakable);	
			
			}

			public function playerTouchUnbreakable (unbreakable:Unbreakable,player:BaseChar )
				{
					FlxObject.separate(unbreakable,player);
							player.resetPosition();
						
				}
			public function playerTouchBreakable (breakable:BreakableBlocks,player:BaseChar )
				{
					FlxObject.separate(breakable,player);
							player.resetPosition();
						
				}


			
				
		


}