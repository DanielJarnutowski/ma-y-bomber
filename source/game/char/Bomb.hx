package game.char;
import game.objects.Explosion;
import game.objects.ExplosionDown;
import flixel.math.FlxRect;



class Bomb extends FlxSprite

{
 

public var defaultBombTimer = 3.0 ;
public var presentBombTimer = 3.0 ;
var explosion: Explosion;
var explosionDown: ExplosionDown;
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
            angle = 180.degToRad();
            explosionDown = new ExplosionDown(new FlxRect(2,2,4,4),angle);
            explosionDown.height = 90;
            explosionDown.width = 32;
            explosionDown.x = (this.x -(explosionDown.width- 32));
            explosionDown.y = (this.y -(explosionDown.height-32)); 
            FlxG.state.add(explosionDown);
            
               
        }
        public function updateExplosion(elapsed: Float)
            {
               presentBombTimer = presentBombTimer - elapsed;
                    if(presentBombTimer <= 0.0)
                        {
                            createExplosion();
                            createExplosionDown();     
                        }
            }
}
