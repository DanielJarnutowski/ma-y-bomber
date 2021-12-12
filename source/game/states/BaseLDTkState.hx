package game.states;

import game.objects.SpeedDown;
import flixel.addons.display.FlxSliceSprite;
import game.ui.Hud;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import game.objects.Explosion;
import flash.system.System;

class BaseLDTkState extends FlxState {
  public var gameTime = 180.0;
  //var gameOverState:GameOverSubState;
  var playerone:BaseChar;
  var playertwo:BaseChar;
  var playerthree:BaseChar;
  var playerfour:BaseChar;
  var explosion:Explosion;
  var collectible:SpeedDown;

  //var gameOverState = new GameOverSubState();

  public var completeLevel:Bool;
  public var gameOver:Bool;
  public var winMatch:Bool;
  public var drawMatch:Bool;

  // Groups
  public var playerOneBombGroup:FlxTypedGroup<Bomb>;
  public var playerTwoBombGroup:FlxTypedGroup<Bomb>;
  public var playerThreeBombGroup:FlxTypedGroup<Bomb>;
  public var playerFourBombGroup:FlxTypedGroup<Bomb>;
  public var explosionGroup:FlxTypedGroup<FlxSliceSprite>;
  public var hud:HUD;
  //public var collectibleGroup:FlxTypedGroup<SpeedDown>;
  public var playerGroup:FlxTypedGroup<BaseChar>;
  public var unbreakableGroup:FlxTypedGroup<Unbreakable>;
  public var breakableGroup:FlxTypedGroup<BreakableBlocks>;
  public var collectibleGroup:FlxSpriteGroup;
  public var backgroundGrp:FlxSpriteGroup;
  public var lvlGrp:FlxSpriteGroup;
  public var decorationGrp:FlxSpriteGroup;
  public var enemyGrp:FlxTypedGroup<Enemy>;
  public var entityGrp:FlxTypedGroup<Actor>;
  public var doorGrp:FlxSpriteGroup;
  public var hazardGrp:FlxSpriteGroup;
  public var subStateColor:FlxColor;
  public var project:ldtkData.LDTkProj;
  public var lvl:ldtkData.LDTkProj.LDTkProj_Level;

  override public function create() {
    subStateColor = 0x99808080;
    hud = new HUD(0.0, 3.0);
    super.create();
    project = Globals.ldtkProj;
    winMatch = false;
    drawMatch = false;
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
     collectibleGroup = new FlxTypedGroup<SpeedDown>();
     bombGroup = new FlxTypedGroup<Bomb>();
     explosionGroup = new FlxSliceSprite<Explosion>();
     playerGroup: FlxTypedGroup<BaseChar>();
     enemyGrp = new FlxTypedGroup<Enemy>();
     levelGrp = new FlxTypedGroup<FlxTilemap>();
     decorationGrp = new FlxTypedGroup<FlxTilemap>();
     breakableGroup = new FlxTypedGroup<BreakableBlocks>();
     unbreakableGroup = new FlxTypedGroup<Unbreakable>();
     
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
    unbreakableGroup = new FlxTypedGroup<Unbreakable>();
    breakableGroup = new FlxTypedGroup<BreakableBlocks>();
    explosionGroup = new FlxTypedGroup<FlxSliceSprite>();
    collectibleGroup = new FlxSpriteGroup();
    var bombCap = 30;
    playerOneBombGroup = new FlxTypedGroup<Bomb>(bombCap);
    playerTwoBombGroup = new FlxTypedGroup<Bomb>(bombCap);
    playerThreeBombGroup = new FlxTypedGroup<Bomb>(bombCap);
    playerFourBombGroup = new FlxTypedGroup<Bomb>(bombCap);
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
  }

  /**
   * Creates the level with collision detection
   */
  public function createLevelLayer() {
    // lvl.l_Tiles.render(lvlGrp);
    lvl.l_Floor_tile.render(lvlGrp);
    // lvlGrp.solid = true;
    lvlGrp.immovable = true;
  }

  public function createEntities() {
    lvl.l_Entities.all_Player1.iter((pl) -> {
      playerone = new Robot(PlayerOne, pl.pixelX, pl.pixelY, explosionGroup);
      playerone.bombGroup = playerOneBombGroup;
      playerone.skullActive = false;
      playerGroup.add(playerone);
    });

    lvl.l_Entities.all_Player2.iter((pl) -> {
      playertwo = new Robot(Cpu, pl.pixelX, pl.pixelY, explosionGroup);
      playertwo.bombGroup = playerTwoBombGroup;
      playerGroup.add(playertwo);
    });

    lvl.l_Entities.all_Unbreakable1.iter((ub) -> {
      var unbreakable1 = new UnbreakableNormalBlocks(ub.pixelX, ub.pixelY);
      unbreakable1.immovable = true;
      unbreakableGroup.add(unbreakable1);
    });

    lvl.l_Entities.all_Unbreakable2.iter((ub) -> {
      var unbreakable2 = new UnbreakableBoxShadow(ub.pixelX, ub.pixelY);
      unbreakable2.immovable = true;
      unbreakableGroup.add(unbreakable2);
    });

    lvl.l_Entities.all_Unbreakable3.iter((ub) -> {
      var unbreakable = new UnbreakableX(ub.pixelX, ub.pixelY);
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
    add(hud);
    add(lvlGrp);
    add(unbreakableGroup);
    add(breakableGroup);
    add(decorationGrp);
    add(hazardGrp);
    add(doorGrp);
    add(enemyGrp);
    add(entityGrp);
    add(explosionGroup);
    add(playerOneBombGroup);
    add(playerTwoBombGroup);
    add(playerThreeBombGroup);
    add(playerFourBombGroup);
    add(playerGroup);
    add(collectibleGroup);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    // Add process for any tile information
    gameTime = gameTime - elapsed;

    if(gameTime <1.0)
      {

        //FlxG.camera.fade(FlxColor.BLACK, 0, false);
        //FlxG.camera.fill(FlxColor.BLACK,false);
        var gameOverScreen:GameOverSubState = new GameOverSubState();
		    openSubState(gameOverScreen);
      }

      if (FlxG.keys.justPressed.ESCAPE)
        {
          var pauseScreen:PauseSubState = new PauseSubState();
          openSubState(pauseScreen);
        }
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