package game.char;

// need to over ride several function of bomb class and call them here to apply new animaiton and abilites
class LightningBomb extends Bomb {
  public function special() {
    presentBombTimer = 1.0;
  }
  
  override public function update(elapsed:Float) {
    super.update(elapsed);
    updateExplosion(elapsed);
  }

  override public function new(x, y, explosionGroup) {
    super(x, y, explosionGroup);
    loadGraphic(AssetPaths.lightning_bomb__png, true, 32, 32, false);
    animation.add('start', [0], 15);
    animation.add('thunder', [1], 15);
    animation.add('impact', [2], 15);
    animation.add('takeoff', [3], 15);
    this.explosionGroup = explosionGroup;
    this.setup();
  }

  override public function updateExplosion(elapsed:Float) {
    presentBombTimer = presentBombTimer - elapsed;

    if (presentBombTimer <= 1.0) {
      animation.play('start');
    }
    if (presentBombTimer <= 0.8) {
      animation.play('thunder');
    }
    if (presentBombTimer <= 0.5) {
      animation.play('impact');
    }
    if (presentBombTimer <= 0.2) {
      animation.play('takeoff');
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
}