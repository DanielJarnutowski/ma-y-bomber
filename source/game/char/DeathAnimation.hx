package game.char;

class DeathAnimation extends FlxSprite
{


    public function new(x:Float, y:Float) {
        super(x, y);
        setupDeath();
    }
    public function setupDeath() {
        loadGraphic(AssetPaths.player_death_anim__png, true, 32, 32, true);
        animation.add('death', [0,1,2,3,4],2,false);
      }


      public function playDeath (x:Float,y:Float)
        {
            animation.play('death');
        }



}