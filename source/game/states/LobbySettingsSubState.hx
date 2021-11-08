package game.states;
import flixel.FlxObject;
import game.ext.UiComponent;
/**
 * Lobby settings to define how game will run setting cpu count, time, and number of rounds
 *///


 //reminder add title text flxttext for lobby settings
 //center everything else

 //add kino move function but edit it, flxtyped group of a different class<>
  //roup:FlxTypedGroup<FlxSprite> replace flxsprite with something else for my container

 //think with flxtext and buttons has in common, make a class for different containers
//position element for sprites and such

// use this for reference

//https://github.com/KinoCreatesGames/cat-catch/blob/master/source/game/ext/SpriteGroupExt.hx
class LobbySettingsSubState extends FlxSubState {
  var mouseCursor:FlxSprite;
  public var objects:FlxTypedGroup<UiComponent>;
  public var titleText:FlxText;
  public var exitButton:FlxButton;
  public var nextButton:FlxButton; 
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
  public var backgroundImage:FlxSprite;

  override public function create() {
    super.create();
    var x = 500.0;
    var y = 100.0;
    bgColor = KColor.BLACK;
    //var verticalPadding = 12;
    var margin = 24;
    var uI = new UiComponent(x,y);
    createBackground();
    add(uI);
    createExit(x,y);
    createNext(x,y);
    
   

    members.iter((member) -> {
      if (Std.isOfType(member, FlxObject)) {
        var displayObj:FlxObject = cast member;
        displayObj.scrollFactor.set(0, 0);
      }
    });
  }

  public function createBackground() {
    backgroundImage = new FlxSprite(0, 0);
    backgroundImage.makeGraphic(FlxG.width, FlxG.height);
    backgroundImage.loadGraphic(AssetPaths.mali_bomber_poster3__png, false,
      576, 576);
    add(backgroundImage);
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

  function createExit(x:Float, y:Float) {
    var margin = 24;
    var xOffSet = 114.0;
    var yOffSet = 40.0;
    exitButton = new FlxButton(x-xOffSet, y+yOffSet, 'Exit');
    exitButton.x -= (exitButton.width + margin);
    add(exitButton);
  }

  function createNext(x:Float, y:Float) {
    var margin = 24;
    var xOffSet = 190.0;
    var yOffSet = 40.0;
    nextButton = new FlxButton(x-xOffSet, y+yOffSet, 'Next', next);
    nextButton.x -= (exitButton.width + margin);
    add(nextButton);
  }
  function next(){
    
    FlxG.switchState(new PlayerOneSelectSubState());
  }

  

  override function update(elapsed:Float) {
    super.update(elapsed);
  }
}