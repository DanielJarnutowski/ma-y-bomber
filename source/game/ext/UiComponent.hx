package game.ext;
import game.ui.TextButton;
import flixel.util.FlxAxes;
import flixel.FlxObject;
import flixel.FlxState;
class UiComponent extends FlxTypedGroup<FlxObject>
{
public var position:FlxPoint;
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

function move( x:Float,
    y:Float) {
members.iter((member) -> {
    var currentPosition = member.getPosition();
    var newPosition = new FlxPoint(x, y);
    newPosition.putWeak();
    var diffPosition = newPosition.subtractPoint(currentPosition);
    // Adjust the relative components by the new position of the container
    var relativeX = currentPosition.x - position.x;
    var relativeY = currentPosition.y - position.y;
    member.x += diffPosition.x + relativeX;
    member.y += diffPosition.y + relativeY;
});
position.set(x, y);
}

public function new (x:Float,y:Float)
    {
    position = new FlxPoint(x,y);
    super();
    createCpu(FlxG.width, 24);
    cpuButtons(x,y);
    createRounds(FlxG.width, 60);
    roundsButtons(x,y);
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
    var xOffset =-25.0;
    var yOffset = -50.0;
    zeroButton = new FlxButton(x+xOffset, y+yOffset, '0', cpuCount);
    zeroButton.x -= (zeroButton.width*4 + 12);
    add(zeroButton);
    oneButton = new FlxButton(x+xOffset, y+yOffset, '1', cpuCount);
    oneButton.x -= (oneButton.width *3+ 12);
    add(oneButton);
    twoButton = new FlxButton(x+xOffset, y+yOffset, '2', cpuCount);
    twoButton.x -= (twoButton.width*2 + 12);
    add(twoButton);
    threeButton = new FlxButton(x+xOffset, y+yOffset, '3', cpuCount);
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
        var xOffset = 5.0;// if i ever need to change y make yoffset variable like i did for x
        var yOffset = 0.0;
    roundOneButton = new FlxButton(x+xOffset, y+yOffset, '1', roundCount);
    roundOneButton.x -= (roundOneButton.width *4+ 12);
    add(roundOneButton);
    roundTwoButton = new FlxButton(x+xOffset, y+yOffset, '2', roundCount);
    roundTwoButton.x -= (roundTwoButton.width*3 + 12);
    add(roundTwoButton);
    roundThreeButton = new FlxButton(x+xOffset, y+yOffset, '3', roundCount);
    roundThreeButton.x -= (roundThreeButton.width*2 + 12);
    add(roundThreeButton);

    //find out how to highlight seletion
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
}

