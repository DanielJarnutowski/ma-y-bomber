package game.char;

import flixel.addons.display.FlxSliceSprite;
import game.objects.Explosion;
import game.objects.ExplosionDown;
import game.objects.ExplosionLeft;
import game.objects.ExplosionRight;
import flixel.math.FlxRect;
import game.states.BaseLDTkState;

class Bomb extends FlxSprite {
  public var presentBombTimer = 3.0;

  var explosionhappened = false;
  var explosion:Explosion;
  var explosionDown:Explosion;
  var explosionLeft:ExplosionLeft;
  var explosionRight:Explosion;

  // We use FlxSliceSprite as the type here to make sure all
  // Explosions are valid within the group we created
  public var explosionGroup:FlxTypedGroup<FlxSliceSprite>;

  private var explosionSound:FlxSound;

  public static inline var SIZE_OFFSET = 10;

  // var explosiongraphic: Explosion;
  // var explosiongraphicDown: ExplosionDown;

  public function new(x, y, explosionGroup) {
    super(x, y);
    // bomb graphic is temporary Kino will get a new graphic later
    loadGraphic(AssetPaths.bomb__png, true, 32, 32, false);
    animation.add('initial', [0], 15);
    animation.add('one', [1], 15);
    animation.add('two', [2], 15);
    animation.add('three', [3], 15);
    animation.add('red', [4], 15);
    animation.add('close', [5], 15);
    animation.add('explode', [6], 15);
    // makeGraphic(32,32,FlxColor.RED);
    this.explosionGroup = explosionGroup;
    this.setup();
  }

  public function setup() {
    explosionSound = FlxG.sound.load(AssetPaths.explosion_sound__wav);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    updateExplosion(elapsed);
  }

  public function createExplosion() {
    explosion = new Explosion(new FlxRect(2, 2, 4, 4), explosionGroup);
    explosion.height = 64; // This will be modified to update game's collisions
    explosion.width = 24;
    explosion.x = (this.x - (explosion.width - 32));
    explosion.y = (this.y - (explosion.height - 32));
    explosionGroup.add(explosion);
  }

  function createExplosionDown() {
    // explosionDown = new ExplosionDown(new FlxRect(2, 2, 4, 4), this.x, this.y);
    explosionDown = new Explosion(new FlxRect(28, 28, 4, 4), explosionGroup);
    explosionDown.height = 64; // This will be modified to update game collisions
    explosionDown.width = 24;
    explosionDown.x = this.x;
    explosionDown.y = this.y;
    explosionGroup.add(explosionDown);
  }

  function createExplosionLeft() {
    explosionLeft = new ExplosionLeft(new FlxRect(2, 2, 4, 4));
    explosionLeft.height = 24;
    explosionLeft.width = 64;
    explosionLeft.x = (this.x - (explosionLeft.width - 32));
    explosionLeft.y = (this.y - (explosionLeft.height - 32));

    explosionGroup.add(explosionLeft);
  }

  function createExplosionRight() {
    explosionRight = new Explosion(new FlxRect(28, 2, 4, 4), explosionGroup);
    explosionRight.width = 64;
    explosionRight.height = 24;
    explosionRight.x = this.x;
    explosionRight.y = this.y + 8;
    explosionGroup.add(explosionRight);
  }

  public function updateExplosion(elapsed:Float) {
    presentBombTimer = presentBombTimer - elapsed;

    if (presentBombTimer <= 3.0) {
      animation.play('initial');
    }
    if (presentBombTimer <= 2.7) {
      animation.play('one');
    }

    if (presentBombTimer <= 2.4) {
      animation.play('two');
    }

    if (presentBombTimer <= 2.1) {
      animation.play('three');
    }

    if (presentBombTimer <= 1.5) {
      animation.play('red');
    }

    if (presentBombTimer <= 1.1) {
      animation.play('close');
    }

    if (presentBombTimer <= 0.5) {
      animation.play('explode');
    }

    if (presentBombTimer <= 0.0 && explosionhappened == false) {
      this.kill();
      createExplosion();
      createExplosionDown();
      createExplosionLeft();
      createExplosionRight();
      sendExplosionSound();
      explosionhappened = true;
    }
  }

  public function sendExplosionSound() {
    explosionSound.play();
  }
}