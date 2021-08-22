package game.objects;

class SpeedDown  extends FlxSprite
{
    var speedTimer = 4.0;

public function new (x,y)
    {
        
        super(x,y);
        loadGraphic(AssetPaths.speeddown__png,true,32,32,false);
        
    }

    override public function update(elapsed:Float) {
        
        super.update(elapsed);
       speedTimer= speedTimer-elapsed;
        if(speedTimer<1.0)
            {
                this.visible=true;
               this.solid= true;
            }
        

         
    }

}