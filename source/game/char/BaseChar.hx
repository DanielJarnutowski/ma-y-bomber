package game.char;

import game.GameTypes.PlayerType;
import game.char.Bomb;
import game.states.BaseLDTkState;

class BaseChar extends FlxSprite {
  public var speed = 460;

  public var controller:PlayerType;
  public var moveToNextTile = false;
  public var previousPosition:FlxPoint;
  public var charDirection:CharDirection;
  public var bombGroup:FlxTypedGroup<Bomb>;
  public var explosionGroup:FlxTypedGroup<Explosion>;
  public var bombDropSound:FlxSound;

  public function new(controller:PlayerType, x:Float, y:Float,
      explosionGroup) {
    this.controller = controller;
    super(x, y);
    this.setup();
  }

  // Used for setting up assets and other important sounds for the player
  public function setup() {
    bombDropSound = FlxG.sound.load(AssetPaths.bomb_pick_up_sound__wav);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    updateMovement(elapsed);
    playerMovement(controller);
    this.bound();
    updateBomb();
  }

  public function updateBomb() {
    if (FlxG.keys.justPressed.M && this.controller == PlayerOne) {
      if (bombGroup != null) {
        var bomb = new Bomb(this.x, this.y, explosionGroup);
        bombGroup.add(bomb);
        // Play sound after bomb is on screen
        bombDropSound.play(true);
      }
    }

    if (FlxG.keys.justPressed.Q && this.controller == PlayerTwo) {
      if (bombGroup != null) {
        var bomb = new Bomb(this.x, this.y, explosionGroup);
        bombGroup.add(bomb);
        bombDropSound.play(true);
      }
    }
  }

  public function updateMovement(elapsed:Float) {
    if (moveToNextTile) {
      switch (charDirection) {
        case Up:
          y -= Globals.MOVEMENT_SPEED;
        case Down:
          y += Globals.MOVEMENT_SPEED;
        case Left:
          x -= Globals.MOVEMENT_SPEED;
        case Right:
          x += Globals.MOVEMENT_SPEED;
      }
    }

    if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
      moveToNextTile = false;
      previousPosition = this.getPosition();
    }
  }

  public function moveTo(direction:CharDirection) {
    if (!moveToNextTile) {
      charDirection = direction;
      moveToNextTile = true;
    }
  }

  public function resetPosition() {
    if (previousPosition != null) {
      moveToNextTile = false;
      this.setPosition(previousPosition.x, previousPosition.y);
    }
  }

  public function playerMovement(controller:PlayerType) {
    if (controller == PlayerOne) {
      if (FlxG.keys.pressed.UP) {
        moveTo(CharDirection.Up);
      }

      if (FlxG.keys.pressed.DOWN) {
        moveTo(CharDirection.Down);
      }

      if (FlxG.keys.pressed.LEFT) {
        moveTo(CharDirection.Left);
      }

      if (FlxG.keys.pressed.RIGHT) {
        moveTo(CharDirection.Right);
      }
    }

    if (controller == PlayerTwo) {
      if (FlxG.keys.pressed.I) {
        moveTo(CharDirection.Up);
      }

      if (FlxG.keys.pressed.K) {
        moveTo(CharDirection.Down);
      }

      if (FlxG.keys.pressed.J) {
        moveTo(CharDirection.Left);
      }

      if (FlxG.keys.pressed.L) {
        moveTo(CharDirection.Right);
      }
    }
  }
}