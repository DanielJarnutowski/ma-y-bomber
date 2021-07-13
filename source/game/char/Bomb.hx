package game.char;
import game.objects.Explosion;
import game.objects.ExplosionDown;
import game.objects.ExplosionLeft;
import game.objects.ExplosionRight;
import flixel.math.FlxRect;



class Bomb extends FlxSprite

{
 

public var defaultBombTimer = 3.0 ;
public var presentBombTimer = 3.0 ;
var explosionhappened = false;
var explosion: Explosion;
var explosionDown: ExplosionDown;
var explosionLeft: ExplosionLeft;
var explosionRight: ExplosionRight;
//var explosiongraphic: Explosion;
//var explosiongraphicDown: ExplosionDown;

    public function new (x,y)
        {
            super(x,y);
            //bomb graphic is temporary Kino will get a new graphic later
            loadGraphic(AssetPaths.bomb_icon_pixel_art_danger_concept_77986701_removebg_preview__png,true,32,32,false);
            //makeGraphic(32,32,FlxColor.RED);
        }

        override public function update(elapsed:Float) {
            super.update(elapsed);
            updateExplosion(elapsed);  
            
        }
         function createExplosion() {
             explosion = new Explosion(new FlxRect(2,2,4,4));
             explosion.height = 90;
             explosion.width = 32;
             explosion.x = (this.x -(explosion.width- 32));
             explosion.y = (this.y -(explosion.height-32)); 
             FlxG.state.add(explosion);    
         }
         function createExplosionDown() {

            explosionDown = new ExplosionDown(new FlxRect(2,2,4,4));
            explosionDown.height = 90;
            explosionDown.width = 32;
            explosionDown.x = (this.x -(explosionDown.width- 64));
            explosionDown.y = (this.y -(explosionDown.height-184)); 
            FlxG.state.add(explosionDown);       
        }

        function createExplosionLeft() {
            explosionLeft = new ExplosionLeft(new FlxRect(2,2,4,4));
            explosionLeft.height = 32;
            explosionLeft.width = 90;
            explosionLeft.x = (this.x - (explosionLeft.width - 32));
            explosionLeft.y = (this.y -(explosionLeft.height-32)); 
            FlxG.state.add(explosionLeft);    
        }

        function createExplosionRight() {

            explosionRight = new ExplosionRight(new FlxRect(2,2,4,4));
            explosionRight.height = 32;
            explosionRight.width = 90;
            explosionRight.x = (this.x -(explosionRight.width- 180));
            explosionRight.y = (this.y -(explosionRight.height-64)); 
            FlxG.state.add(explosionRight);       
        }
        public function updateExplosion(elapsed: Float)
            {
               presentBombTimer = presentBombTimer - elapsed;
                    if(presentBombTimer <= 0.0 && explosionhappened==false)
                        {
                            createExplosion();
                            createExplosionDown();
                            createExplosionLeft();
                            createExplosionRight();
                            explosionhappened= true;     
                        }
            }
}
