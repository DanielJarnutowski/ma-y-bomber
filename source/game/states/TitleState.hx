package game.states;

import game.ui.TextButton;
import flixel.util.FlxAxes;

/**
  * Add Press Start Before entering main scene for title
  * as part of the update functionality
  //title screen look at this to work at UI
 */
class TitleState extends FlxState {
  public var pressStartText:FlxText;
  public var playButton:TextButton;
  public var optionsButton:TextButton;
  public var creditsButton:TextButton;
  public var completeFadeStart:Bool;
  public var backgroundImage:FlxSprite;

  #if desktop
  public var exitButton:TextButton;
  #end

  override public function create() {
    FlxG.mouse.visible = true;
    bgColor = KColor.RICH_BLACK_FORGRA;
    // Create Title Text
    var text = new FlxText(0, 0, -1, Globals.GAME_TITLE, 32);
    add(text);
    text.alignment = CENTER;
    text.screenCenter();
    completeFadeStart = false;
    initializeSave();
    createBackground();
    createPressStart();
    createButtons();
    createControls();
    createCredits();
    createVersion();
    super.create();
    // Play background music on game start up
    FlxG.sound.playMusic(AssetPaths.Takeover_Abyss__ogg);
  }

  public function createBackground() {
    backgroundImage = new FlxSprite(0, 0);
    backgroundImage.makeGraphic(FlxG.width, FlxG.height);
    backgroundImage.loadGraphic(AssetPaths.mali_bomber_poster3__png, false,
      576, 576);
    add(backgroundImage);
  }

  public function createPressStart() {
    pressStartText = new FlxText(0, 0, -1, 'Press Any Button To Start',
      Globals.FONT_N);
    pressStartText.screenCenter();
    pressStartText.y += -30;
    // add later
    add(pressStartText);
    pressStartText.flicker(0, .4);
  }

  public function createButtons() {
    // Create Buttons
    var y = -80;
    playButton = new TextButton(0, 0, Globals.TEXT_START, Globals.FONT_N,
      clickStart);
    playButton.hoverColor = KColor.BURGUNDY;
    playButton.clickColor = KColor.BURGUNDY;
    playButton.screenCenter();
    playButton.y += y;
    y += 40;
    optionsButton = new TextButton(0, 0, Globals.TEXT_OPTIONS, Globals.FONT_N,
      clickOptions);
    optionsButton.hoverColor = KColor.BURGUNDY;
    optionsButton.clickColor = KColor.BURGUNDY;
    optionsButton.screenCenter();
    optionsButton.y += y;
    y += 40;
    creditsButton = new TextButton(0, 0, Globals.TEXT_CREDITS, Globals.FONT_N,
      clickCredits);
    creditsButton.hoverColor = KColor.BURGUNDY;
    creditsButton.clickColor = KColor.BURGUNDY;
    creditsButton.screenCenter();
    creditsButton.y += y;
    y += 40;
    #if desktop
    exitButton = new TextButton(0, 0, Globals.TEXT_EXIT, Globals.FONT_N,
      clickExit);
    exitButton.hoverColor = KColor.BURGUNDY;
    exitButton.clickColor = KColor.BURGUNDY;
    exitButton.screenCenter();
    exitButton.y += y;
    #end
    // Add Buttons

    playButton.canClick = false;
    playButton.alpha = 0;
    optionsButton.alpha = 0;
    creditsButton.canClick = false;
    creditsButton.alpha = 0;
    add(playButton);
    add(optionsButton);
    add(creditsButton);
    #if desktop
    exitButton.canClick = false;
    exitButton.alpha = 0;
    add(exitButton);
    #end
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    updatePressStart(elapsed);
  }

  public function updatePressStart(elapsed:Float) {
    var keyPressed = FlxG.keys.firstPressed();
    if (keyPressed != -1) {
      pressStartText.stopFlickering();
      pressStartText.visible = false;
    } else if (pressStartText.visible) {}

    var fadeTime = 0.25;
    if (!pressStartText.visible && !pressStartText.isFlickering()
      && completeFadeStart == false) {
      playButton.fadeIn(fadeTime);
      if (playButton.alpha >= .9) {
        optionsButton.fadeIn(fadeTime);
      }
      if (optionsButton.alpha >= .9) {
        creditsButton.fadeIn(fadeTime);
        #if !desktop
        completeFadeStart = true;
        #end
      }

      #if desktop
      if (creditsButton.alpha >= .9) {
        exitButton.fadeIn(fadeTime);
        completeFadeStart = true;
      }
      exitButton.visible = true;
      #end
    }

    if (completeFadeStart) {
      playButton.canClick = true;
      optionsButton.canClick = true;
      creditsButton.canClick = true;
      #if desktop
      exitButton.canClick = true;
      #end
    }
  }

  public function clickStart() {
    // var introText = DepotData.Cutscene.lines.getByFn((el) ->
    // el.name == 'Intro');
    // FlxG.switchState(new CutsceneState(new HubState(),
    // introText.cutsceneText));
    openSubState(new LobbySettingsSubState());
  }

  public function clickOptions() {
    openSubState(new SettingsSubState());
  }

  public function clickCredits() {
    openSubState(new CreditsSubState());
  }

  #if desktop
  public function clickExit() {
    Sys.exit(0);
  }
  #end

  public function createControls() {
    var textWidth = 200;
    var textSize = 12;
    var controlsText = new FlxText(20, FlxG.height - 100, textWidth,
      'How To Move:
UP: W/UP
Left/Right: A/Left, S/Right', textSize);
    // add(controlsText);
  }

  public function createCredits() {
    var textWidth = 300;
    var textSize = 15;
    var creditsText = new FlxText(FlxG.width - textWidth, FlxG.height - 550,
      textWidth, 'Created by KinoCreates', textSize);
    creditsText.setPosition(330, 20);
    add(creditsText);
  }

  public function createVersion() {
    var textWidth = 200;
    var textSize = 16;
    var versionText = new FlxText(FlxG.width - textWidth, FlxG.height - 550,
      textWidth, Globals.TEXT_VERSION, textSize);
    // versionText.screenCenter(FlxAxes.X);
    versionText.setPosition(25, 20);
    add(versionText);
  }

  function initializeSave() {
    DataPlugin.initializeSave();
    DataPlugin.Save.loadSettings();
  }
}