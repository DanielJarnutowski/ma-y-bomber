package game.states;

import game.states.LevelSelectSubstate.LevelSelectSubState;
import flixel.FlxObject;
import game.ext.UiComponent;

class PlayerTwoSelectSubState extends FlxSubState {
  var mouseCursor:FlxSprite;

  public var objects:FlxTypedGroup<UiComponent>;
  public var titleText:FlxText;
  public var exitButton:FlxButton;
  public var nextButton:FlxButton;
  public var choiceOneButton:FlxButton;
  public var choiceTwoButton:FlxButton;
  public var choiceThreeButton:FlxButton;
  public var choiceFourButton:FlxButton;
  public var textSpeedText:FlxText;
  public var ninjaImage:FlxSprite;
  public var robotImage:FlxSprite;
  public var wizardImage:FlxSprite;
  public var turtleImage:FlxSprite;
  public var backgroundImage:FlxSprite;
  public var lobby:LobbySettingsSubState;

  public function new(lobby:LobbySettingsSubState){ 
    super();
    this.lobby = lobby;
  }

  override public function create() {
    super.create();
    var x = 500.0;
    var y = 100.0;
    createBackground();
    createWhichCharacter();
    charButtons(x, y);
    createExit();
    createNext();
    createNinjaImage();
    createRobotImage();
    createTurtleImage();
    createWizardImage();

    // bgColor = KColor.BLACK;
  }

  public function createBackground() {
    backgroundImage = new FlxSprite(0, 0);
    backgroundImage.makeGraphic(FlxG.width, FlxG.height);
    backgroundImage.loadGraphic(AssetPaths.mali_bomber_poster3__png, false,
      576, 576);
    add(backgroundImage);
  }

  public function createNinjaImage() {
    ninjaImage = new FlxSprite(152, 70);
    ninjaImage.makeGraphic(FlxG.width, FlxG.height);
    ninjaImage.loadGraphic(AssetPaths.ninja_solo__png, false, 100, 100);
    add(ninjaImage);
  }

  public function createRobotImage() {
    robotImage = new FlxSprite(312, 70);
    robotImage.makeGraphic(FlxG.width, FlxG.height);
    robotImage.loadGraphic(AssetPaths.robot_player__png, false, 100, 100);
    add(robotImage);
  }

  public function createTurtleImage() {
    turtleImage = new FlxSprite(232, 70);
    turtleImage.makeGraphic(FlxG.width, FlxG.height);
    turtleImage.loadGraphic(AssetPaths.turtle_character_player__png, false,
      100, 100);
    add(turtleImage);
  }

  public function createWizardImage() {
    wizardImage = new FlxSprite(392, 70);
    wizardImage.makeGraphic(FlxG.width, FlxG.height);
    wizardImage.loadGraphic(AssetPaths.wizard_player__png, false, 100, 100);
    add(wizardImage);
  }

  function createWhichCharacter() {
    var x = 530.0;
    var y = 100.0;
    // var verticalPadding = 24;
    titleText = new FlxText(10, 24, -1, "Player Two choose your character?",
      Globals.FONT_L);
    titleText.screenCenterHorz();
    add(titleText);
  }

  function charButtons(x:Float, y:Float) {
    // buttons below char images, each button runs a function for each character
    var xOffset = -40.0;
    var yOffset = -50.0;
    choiceOneButton = new FlxButton(x + xOffset, y + yOffset, 'Ninja', choice);
    choiceOneButton.x -= (choiceOneButton.width * 4 + 12);
    add(choiceOneButton);
    choiceTwoButton = new FlxButton(x + xOffset, y + yOffset, 'Turtle', choice);
    choiceTwoButton.x -= (choiceTwoButton.width * 3 + 12);
    add(choiceTwoButton);
    choiceThreeButton = new FlxButton(x + xOffset, y + yOffset, 'Robot',
      choice);
    choiceThreeButton.x -= (choiceThreeButton.width * 2 + 12);
    add(choiceThreeButton);
    choiceFourButton = new FlxButton(x + xOffset, y + yOffset, 'Mage', choice);
    choiceFourButton.x -= (choiceFourButton.width + 12);
    add(choiceFourButton);
  } // onclick button function

  function choice() {}

  function createExit() {
    var x = 510.0;
    var y = 100.0;
    var margin = 24;
    var xOffSet = 124.0;
    var yOffSet = 20.0;
    exitButton = new FlxButton(x - xOffSet, y + yOffSet, 'Exit',exitSettings);
    exitButton.x -= (exitButton.width + margin);
    add(exitButton);
  }

  function createNext() {
    var x = 510.0;
    var y = 100.0;
    var margin = 24;
    var xOffSet = 200.0;
    var yOffSet = 20.0;
    nextButton = new FlxButton(x - xOffSet, y + yOffSet, 'Next', next);
    nextButton.x -= (nextButton.width + margin);
    add(nextButton);
  }

  function textSpeedUp() {
    switch (textSpeedText.text) {
      case 'Normal':
        textSpeedText.text = 'Fast';
      case 'Slow':
        textSpeedText.text = 'Normal';
      case 'Fast':
        textSpeedText.text = 'Slow';
      case _:
        // Do nothing
    }
  }

  function textSpeedDown() {
    switch (textSpeedText.text) {
      case 'Normal':
        textSpeedText.text = 'Slow';
      case 'Slow':
        textSpeedText.text = 'Fast';
      case 'Fast':
        textSpeedText.text = 'Normal';
      case _:
        // Do nothing
    }
  }

  function updateTextMode() {}

  function exitSettings() {
    this.close();
  }

  function next() {
    // saveSettings();
    openSubState(new LevelSelectSubState(lobby));
  }

  function saveSettings() {
    var save = DataPlugin.Save.createSaveSettings();
    save.data.volume = FlxG.sound.volume;
    save.close();
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }
} 
