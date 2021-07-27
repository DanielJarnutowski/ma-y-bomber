package game.states;

class GameSelectState extends FlxState {
  public var background:FlxSprite;
  public var playerOne:FlxSprite;
  public var playerTwo:FlxSprite;
  public var playerThree:FlxSprite;
  public var playerFour:FlxSprite;
  public var titleText:FlxText;
  public var levelPicture:FlxSprite;

  override public function create() {
    super.create();
    bgColor = KColor.RICH_BLACK_FORGRA;
    this.createTitleText();
    this.createPlayers();
    this.createLevelPicture();
  }

  public function createTitleText() {
    titleText = new FlxText(0, 30, -1, 'Choose your character', Globals.FONT_L);
    titleText.screenCenterHorz();
    this.add(titleText);
  }

  // Create the player sprites temporarily for rendering on screen
  public function createPlayers() {
    var padding = 60;
    var positions = [
      FlxPoint.weak(padding, padding),
      FlxPoint.weak(FlxG.width - padding, padding),
      FlxPoint.weak(padding, FlxG.height - padding),
      FlxPoint.weak(FlxG.width - padding, FlxG.height - padding)
    ];
    for (i in 0...positions.length) {
      var point = positions[i];
      switch (i) {
        case 0:
          playerOne = new FlxSprite(point.x, point.y);
          playerOne.makeGraphic(32, 32, KColor.WHITE);
          this.add(playerOne);
        case 1:
          playerTwo = new FlxSprite(point.x, point.y);
          playerTwo.makeGraphic(32, 32, KColor.WHITE);
          this.add(playerTwo);
        case 2:
          playerThree = new FlxSprite(point.x, point.y);
          playerThree.makeGraphic(32, 32, KColor.WHITE);
          this.add(playerThree);
        case 3:
          playerFour = new FlxSprite(point.x, point.y);
          playerFour.makeGraphic(32, 32, KColor.WHITE);
          this.add(playerFour);
        case _:
          // Do nothing this case
      }
    }
  }

  // This will be used to change the displayed level picture on selection
  public function createLevelPicture() {
    levelPicture = new FlxSprite(0, 0);
    levelPicture.makeGraphic(cast FlxG.width / 3, cast FlxG.height / 3,
      KColor.WHITE);
    levelPicture.screenCenter();

    this.add(levelPicture);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    updateTitle();
  }

  public function updateTitle() {
    var pressedCancel = FlxG.keys.anyJustPressed([X, ESCAPE, Q]);
    if (pressedCancel) {
      FlxG.camera.fade(KColor.BLACK, 1, false, () -> {
        FlxG.camera.fade(KColor.BLACK, 1, true);
        FlxG.switchState(new TitleState());
      });
    }
  }
}