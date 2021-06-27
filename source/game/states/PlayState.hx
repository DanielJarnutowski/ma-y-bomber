package game.states;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends BaseLDTkState {
	
	

	override public function create() {
		super.create();
		createLevel(project.all_levels.Level_0);
	
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

			public function playerTouchUnbreakable (unbreakable:UnbreakableBlocks,player:BaseChar )
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