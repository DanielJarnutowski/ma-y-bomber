package game.char;
import game.objects.Explosion;
import flixel.math.FlxRect;



class Bomb extends FlxSprite

{
 

public var defaultBombTimer = 3.0 ;
public var presentBombTimer = 3.0 ;
var explosion: Explosion;
var explosiontwo: Explosion;
var explosiongraphic: Explosion;

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
           
             explosion = new Explosion(new FlxRect(10,10,20,20));
             explosion.height = 90;
             explosion.width = 29;
             explosion.x = this.x;
             explosion.y = this.y; 
            FlxG.state.add(explosion);   
            
         }

        

         
            
             
      
        

        public function updateExplosion(elapsed: Float)
            {
               presentBombTimer = presentBombTimer - elapsed;

                    if(presentBombTimer <= 0.0)
                        {
                            createExplosion();
                          
                            //createExplosiontwo();
                        }
            }
}
