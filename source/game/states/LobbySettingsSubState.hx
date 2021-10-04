package game.states;
import flixel.FlxObject;

/**
 * Lobby settings to define how game will run setting cpu count, time, and number of rounds
 *///


 //reminder add title text flxttext for lobby settings
 //center everything else
class LobbySettingsSubState extends FlxSubState {
  var mouseCursor:FlxSprite;

  public var titleText:FlxText;
  public var exitButton:FlxButton;
  public var zeroButton:FlxButton;
  public var oneButton:FlxButton;
  public var twoButton:FlxButton;
  public var threeButton:FlxButton;
  public var roundOneButton:FlxButton;
  public var roundTwoButton:FlxButton;
  public var roundThreeButton:FlxButton;
  public var textSpeedLabel:FlxText;
  public var textSpeedText:FlxText;
  public var ninjaImage:FlxSprite;
  public var robotImage:FlxSprite;
  public var wizardImage:FlxSprite;
  public var turtleImage:FlxSprite;

  override public function create() {
    super.create();
    bgColor = KColor.BLACK;
    //var verticalPadding = 12;
    var margin = 24;
    createNinjaImage();
    createRobotImage();
    createTurtleImage();
    createWizardImage();
    createCpu(FlxG.width, 24);
    cpuButtons(FlxG.width, 36);
    createRounds(FlxG.width, 60);
    roundsButtons(FlxG.width,85);
    createExit(FlxG.width, 36);
    createNext(FlxG.width, 36);
   

    members.iter((member) -> {
      if (Std.isOfType(member, FlxObject)) {
        var displayObj:FlxObject = cast member;
        displayObj.scrollFactor.set(0, 0);
      }
    });
  }

  public function createNinjaImage() {
    ninjaImage = new FlxSprite(0, 200);//use 8 images!!!
    ninjaImage.makeGraphic(FlxG.width, FlxG.height);
    ninjaImage.loadGraphic(AssetPaths
      .ninja_8__png, false,
      100, 100);
    add(ninjaImage);
  }

  public function createRobotImage() {
    robotImage = new FlxSprite(0, 300);
    robotImage.makeGraphic(FlxG.width, FlxG.height);
    robotImage.loadGraphic(AssetPaths.robot_8__png, false,
      100, 100);
    add(robotImage);
  }

  public function createTurtleImage() {
    turtleImage = new FlxSprite(0, 400);
    turtleImage.makeGraphic(FlxG.width, FlxG.height);
    turtleImage.loadGraphic(AssetPaths.turtle_character_8__png, false,
      100, 100);
    add(turtleImage);
   
  }

  public function createWizardImage() {
    wizardImage = new FlxSprite(0,500);
    wizardImage.makeGraphic(FlxG.width, FlxG.height);
    wizardImage.loadGraphic(AssetPaths.wizard_8__png, false,
      100, 100);
    add(wizardImage);
  }

  function createCpu(x:Float, y:Float) {
    //var verticalPadding = 24;
    titleText = new FlxText(0, 24, -1, "How many cpu?",
      Globals.FONT_L);
    titleText.screenCenterHorz();
    add(titleText);
  }

  function cpuButtons(x:Float, y:Float)
    {
    zeroButton = new FlxButton(x, y+12, '0', cpuCount);
    zeroButton.x -= (zeroButton.width*4 + 12);
    add(zeroButton);
    oneButton = new FlxButton(x, y+12, '1', cpuCount);
    oneButton.x -= (oneButton.width *3+ 12);
    add(oneButton);
    twoButton = new FlxButton(x, y+12, '2', cpuCount);
    twoButton.x -= (twoButton.width*2 + 12);
    add(twoButton);
    threeButton = new FlxButton(x, y+12, '3', cpuCount);
    threeButton.x -= (threeButton.width + 12);
    add(threeButton);

    //find out how to highlight seletion
    }

  function createRounds(x:Float, y:Float) {
    var verticalPadding = 72;
    titleText = new FlxText(0, verticalPadding, -1,
     "How many rounds ?" , Globals.FONT_L);
    titleText.screenCenterHorz();
    add(titleText);
  }

  function roundsButtons(x:Float, y:Float)
    {
    roundOneButton = new FlxButton(x, y+12, '1', roundCount);
    roundOneButton.x -= (roundOneButton.width *4+ 12);
    add(roundOneButton);
    roundTwoButton = new FlxButton(x, y+12, '2', roundCount);
    roundTwoButton.x -= (roundTwoButton.width*3 + 12);
    add(roundTwoButton);
    roundThreeButton = new FlxButton(x, y+12, '3', roundCount);
    roundThreeButton.x -= (roundThreeButton.width*2 + 12);
    add(roundThreeButton);

    //find out how to highlight seletion
    }

  function createExit(x:Float, y:Float) {
    var margin = 24;
    exitButton = new FlxButton(x-150, y+120, 'Exit', exitSettings);
    exitButton.x -= (exitButton.width + margin);
    add(exitButton);
  }

  function createNext(x:Float, y:Float) {
    var margin = 24;
    exitButton = new FlxButton(x-60, y+120, 'Next', next);
    exitButton.x -= (exitButton.width + margin);
    add(exitButton);
  }

  function createTextSpeed(x:Float, y:Float) {
    var horzSpacing = 12;
    textSpeedLabel = new FlxText(x, y, -1, 'Text Speed', Globals.FONT_N);
    var textSpdBtnL = new FlxButton(horzSpacing
      + textSpeedLabel.x
      + textSpeedLabel.width, y, '',
      textSpeedDown);
    textSpeedText = new FlxText(horzSpacing
      + textSpdBtnL.x
      + textSpdBtnL.width, y, -1, 'Normal',
      Globals.FONT_N);
    var textSpdBtnR = new FlxButton(horzSpacing
      + textSpeedText.x
      + textSpeedText.width, y, textSpeedUp);

    add(textSpeedLabel);
    add(textSpeedText);
    add(textSpdBtnL);
    add(textSpdBtnR);
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
    close();
  }

  function next(){

  }

  function cpuCount() {
      //function to decide cpu count
  }

  function roundCount() {
      //function to decide how many rounds
  }

  function roundTime() {
      //function to change round time
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }
}