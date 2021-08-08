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
  var explosionDown:ExplosionDown;
  var explosionLeft:ExplosionLeft;
  var explosionRight:ExplosionRight;

  // We use FlxSliceSprite as the type here to make sure all
  // Explosions are valid within the group we created
  public var explosionGroup:FlxTypedGroup<FlxSliceSprite>;

  private var explosionSound:FlxSound;

  // var explosiongraphic: Explosion;
  // var explosiongraphicDown: ExplosionDown;

  public function new(x, y, explosionGroup) {
    super(x, y);
    // bomb graphic is temporary Kino will get a new graphic later
    loadGraphic(AssetPaths.bomb__png,
      true, 32, 32, false);
      animation.add('initial', [0],15);
      animation.add('one', [1],15);
      animation.add('two', [2],15);
      animation.add('three',[3],15);
      animation.add('red', [4],15);
      animation.add('close', [5],15);
      animation.add('explode', [6],15);
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
    explosion.height = 64;
    explosion.width = 32;
    explosion.x = (this.x - (explosion.width - 32));
    explosion.y = (this.y - (explosion.height - 32));
    explosionGroup.add(explosion);
  }

  function createExplosionDown() {
    explosionDown = new ExplosionDown(new FlxRect(2, 2, 4, 4));
    explosionDown.height = 64;
    explosionDown.width = 32;
    explosionDown.x = (this.x - (explosionDown.width - 64));
    //explosionDown.x = (this.x );
    explosionDown.y = (this.y - (explosionDown.height - 128));
    //explosionDown.y = (this.y );
    //explosionDown.angle = 90;
    explosionGroup.add(explosionDown);
  }

  function createExplosionLeft() {
    explosionLeft = new ExplosionLeft(new FlxRect(2, 2, 4, 4));
    explosionLeft.height = 32;
    explosionLeft.width = 64;
    explosionLeft.x = (this.x - (explosionLeft.width - 32));
    explosionLeft.y = (this.y - (explosionLeft.height - 32));
    explosionGroup.add(explosionLeft);
  }

  function createExplosionRight() {
    explosionRight = new ExplosionRight(new FlxRect(2, 2, 4, 4));
    explosionRight.height = 32;
    explosionRight.width = 64;
    explosionRight.x = (this.x - (explosionRight.width - 128));
    explosionRight.y = (this.y - (explosionRight.height - 64));
    //explosionRight.angle = 180;
   // explosionRight.solid = true;
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