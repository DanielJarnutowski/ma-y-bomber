package game.states;

import flixel.group.FlxSpriteGroup;


class BaseLDTkState extends FlxState  {
var playerone: BaseChar;
var playertwo: BaseChar;
var playerthree: BaseChar;
var playerfour: BaseChar;
public var completeLevel:Bool;
public var gameOver:Bool;

	// Groups
	public var bombGroup:FlxTypedGroup<Bomb>;
	public var playerGroup: FlxTypedGroup<BaseChar>;
	public var unbreakableGroup: FlxTypedGroup<UnbreakableBlocks>;
	public var breakableGroup: FlxTypedGroup<BreakableBlocks>;
	public var backgroundGrp:FlxSpriteGroup;
	public var lvlGrp:FlxSpriteGroup;
	public var decorationGrp:FlxSpriteGroup;
	public var enemyGrp:FlxTypedGroup<Enemy>;
	public var entityGrp:FlxTypedGroup<Actor>;
	public var doorGrp:FlxSpriteGroup;
	public var hazardGrp:FlxSpriteGroup;

	public var project:ldtkData.LDTkProj;
	public var lvl:ldtkData.LDTkProj.LDTkProj_Level;

	override public function create() {
		super.create();
		project = Globals.ldtkProj;
		completeLevel = false;
		gameOver = false;
	}

	public function createLevel(?level:ldtkData.LDTkProj.LDTkProj_Level) {
		if (level != null) {
			lvl = level;
		}

		createGroups();
		createEntities();
		createLevelInformation();
		createUI();
		addGroups();
	}

	/**
		* Creates the groups that are being used on the level
				* ```haxe
		 bombGroup = new FlxTypedGroup<Bomb>();
		 playerGroup: FlxTypedGroup<BaseChar>();
		 enemyGrp = new FlxTypedGroup<Enemy>();
		 levelGrp = new FlxTypedGroup<FlxTilemap>();
		 decorationGrp = new FlxTypedGroup<FlxTilemap>();
		 breakableGroup = new FlxTypedGroup<BreakableBlocks>();
		 unbreakableGroup = new FlxTypedGroup<UnbreakableBlocks>();
		 
				* ```
	 */
	public function createGroups() {
		
		enemyGrp = new FlxTypedGroup<Enemy>();
		lvlGrp = new FlxSpriteGroup();
		decorationGrp = new FlxSpriteGroup();
		hazardGrp = new FlxSpriteGroup();
		backgroundGrp = new FlxSpriteGroup();
		doorGrp = new FlxSpriteGroup();
		entityGrp = new FlxTypedGroup<Actor>();
		unbreakableGroup = new FlxTypedGroup<UnbreakableBlocks>();
		breakableGroup = new FlxTypedGroup<BreakableBlocks>();
		bombGroup = new FlxTypedGroup<Bomb>();
		playerGroup = new FlxTypedGroup<BaseChar>();
	}

		

	/**
	 * Creates the level information for the level, including
	 		* the actual tiled level map.
	 */
	public function createLevelInformation() {
		createLevelMap();
		// Additional Elements Below UI
	}

	public function createLevelMap() {

		createBackgroundLayer();
		createLevelLayer();
	}

	/**
	 * Creates the background layer with no collision detection.
	 */
	public function createBackgroundLayer() {
		lvl.l_Background.render(backgroundGrp);
		// Tint Background
		backgroundGrp.color = 0xF0C0C0C0;
	}

	/**
	 * Creates the level with collision detection
	 */
	public function createLevelLayer() {
		lvl.l_Tiles.render(lvlGrp);
		//lvlGrp.solid = true;
		lvlGrp.immovable = true;
	
	}

	public function createEntities() 
		{
			lvl.l_Entities.all_Player1.iter((pl) -> {
				playerone = new BaseChar(PlayerOne, pl.pixelX, pl.pixelY);
				playerone.loadGraphic(AssetPaths.turtle_character_player__png,true,32,32,false);
				playerone.bombGroup = bombGroup;
				playerGroup.add(playerone);
						});

			lvl.l_Entities.all_Player2.iter((pl) -> {
				playertwo = new BaseChar(PlayerTwo, pl.pixelX, pl.pixelY);
				playertwo.loadGraphic(AssetPaths.ninja_character_player__png,true,32,32,false);
				playertwo.bombGroup = bombGroup;
				playerGroup.add(playertwo);
			});

			lvl.l_Entities.all_Entity.iter((ub) -> {
			
					var unbreakable = new UnbreakableBlocks(ub.pixelX, ub.pixelY);
					unbreakable.immovable = true;
					unbreakableGroup.add(unbreakable);
				});
				
			lvl.l_Entities.all_Breakable.iter((br) -> {
				
					var breakable = new BreakableBlocks(br.pixelX, br.pixelY);
					breakable.immovable = true;
					breakableGroup.add(breakable);
					});




		}

	/**
	 * Function for creating the UI for the game.
	 */
	public function createUI() {}

	/**
		* Add additional groups to your tiled map
		* 
		* ```haxe
			
			add(lvlGrp);
			add(decorationGrp);
			add(enemyGrp);
			add(playerGroup);
			add(breakableGroup);
			add(unbreakableGroup);
			
			* ```
	 */
	public function addGroups() {

		add(backgroundGrp);
		add(lvlGrp);
		add(unbreakableGroup);
		add(breakableGroup);
		add(decorationGrp);
		add(hazardGrp);
		add(doorGrp);
		add(enemyGrp);
		add(entityGrp);
		add(bombGroup);
		add(playerGroup);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		// Add process for any tile information
		processCollision();
		processLevel(elapsed);
	}

	/**
	 * Used for handling any collisions within the level.
	 */
	public function processCollision() {}

	/**
	 * Used for any processing of the level in the update function.
	 * @param elapsed 
	 */
	public function processLevel(elapsed:Float) {}
}