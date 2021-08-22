package game.objects;

class SpeedDown  extends Collectible
{
    var timer = 4.0;

public function new (x,y)
    {
        
        super(x,y);
        loadGraphic(AssetPaths.speeddown__png,true,32,32,false);
        
    }

    override public function update(elapsed:Float) {
        
        super.update(elapsed);
       timer= timer-elapsed;
        if(timer<1.0)
            {
                this.visible=true;
               this.solid= true;
               
            }
        

         
    }

}