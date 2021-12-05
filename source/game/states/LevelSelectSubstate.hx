package game.states;
import flixel.FlxObject;
import game.ext.UiComponent;


class LevelSelectSubState extends FlxSubState {
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
  public var backgroundImage:FlxSprite;
  public var darkLevelImage:FlxSprite;
  public var starterLevelImage:FlxSprite;
  public var fireLevelImage:FlxSprite;
  public var iceLevelImage:FlxSprite;

  override public function create() {
    super.create();
    //var x = 500.0;
    //var y = 100.0;
    createBackground();
    createWhichLevel();
    levelButtons(500,100);
    createExit();
    createNext();
    createDarkLevelImage();
    createStarterLevelImage();
   createFireLevelImage();
    createIceLevelImage(50,50);
    
    //bgColor = KColor.BLACK;
  }

  public function createBackground() {
    backgroundImage = new FlxSprite(0, 0);
    backgroundImage.makeGraphic(FlxG.width, FlxG.height);
    backgroundImage.loadGraphic(AssetPaths.mali_bomber_poster3__png, false,
      576, 576);
    add(backgroundImage);
  }
    
    function createWhichLevel() {
      var x = 530.0;
      var y = 100.0;
      //var verticalPadding = 24;
      titleText = new FlxText(10, 24, -1, "Choose Your Level",
        Globals.FONT_L);
      titleText.screenCenterHorz();
      add(titleText);
    }

    public function createDarkLevelImage() {
        darkLevelImage = new FlxSprite(-175,-150);
        darkLevelImage.makeGraphic(FlxG.width, FlxG.height);
        darkLevelImage.loadGraphic(AssetPaths.darklevel__png
            , false,
          100, 100);
          darkLevelImage.scale.x=.25;
          darkLevelImage.scale.y=.25;
        add(darkLevelImage);
      }
    
      public function createStarterLevelImage() {
        starterLevelImage = new FlxSprite(-45, -286);
        starterLevelImage.makeGraphic(FlxG.width, FlxG.height);
        starterLevelImage.loadGraphic(AssetPaths.starterlevel__png, false,
          100, 100);
          starterLevelImage.scale.x=.16;
          starterLevelImage.scale.y=.17;
        add(starterLevelImage);
      }
    
      public function createFireLevelImage() {
        fireLevelImage = new FlxSprite(-395, -218);
        fireLevelImage.makeGraphic(FlxG.width, FlxG.height);
        fireLevelImage.loadGraphic(AssetPaths.firelevel__png, false,
          100, 100);
          fireLevelImage.scale.x=.14;
          fireLevelImage.scale.y=.13;
        add(fireLevelImage);
      }
    
      public function createIceLevelImage(x:Float, y:Float) {
        iceLevelImage = new FlxSprite(-131,-221);
        iceLevelImage.makeGraphic(FlxG.width, FlxG.height);
        iceLevelImage.loadGraphic(AssetPaths.icelevel__png, false,
         100, 100);
         iceLevelImage.scale.x=.13;
         iceLevelImage.scale.y=.13;
        add(iceLevelImage);
      }
    function levelButtons(x:Float, y:Float)
      {
        //buttons below char images, each button runs a function for each character
      var xOffset =25.0;
      var yOffset = 10;
      choiceOneButton = new FlxButton(x+xOffset, y+yOffset, 'Dark', choice);
      choiceOneButton.x -= (choiceOneButton.width*4 + 12);
      add(choiceOneButton);
      choiceTwoButton = new FlxButton(687+xOffset, y+yOffset, 'Light', choice);
      choiceTwoButton.x -= (choiceTwoButton.width *3+ 12);
      add(choiceTwoButton);
      choiceThreeButton = new FlxButton(168+xOffset, 255+yOffset, 'Fire', choice);
      add(choiceThreeButton);
      choiceFourButton = new FlxButton(435+xOffset, 255+yOffset, 'Ice', choice);
      //choiceFourButton.x -= (choiceFourButton.width + 12);
      add(choiceFourButton);
      }//onclick button function
  
  


      function choice()
        {

        }
  
    function createExit() {
      var x = 510.0;
      var y = 500.0;
      var margin = 24;
      var xOffSet = 124.0;
      var yOffSet = 20.0;
      exitButton = new FlxButton(x-xOffSet, y+yOffSet, 'Exit');
      exitButton.x -= (exitButton.width + margin);
      add(exitButton);
    }
  
    function createNext() {
      var x = 510.0;
      var y = 500.0;
      var margin = 24;
      var xOffSet = 200.0;
      var yOffSet = 20.0;
      exitButton = new FlxButton(x-xOffSet, y+yOffSet, 'Next', next);
      exitButton.x -= (exitButton.width + margin);
      add(exitButton);
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
    //saveSettings();
    close();
  }

  function next(){
    //saveSettings();
  }

  function saveSettings() {
		var save = DataPlugin.Save.createSaveSettings();
		save.data.volume = FlxG.sound.volume;
		 save.data.textMode = textSpeedText.text;
		save.close();
	}
  override function update(elapsed:Float) {
    super.update(elapsed);
  }
}