package game.objects;

class BombUp  extends Collectible
{
    public var timer = 4.06;

public function new (x,y)
    {
        super(x,y);
        loadGraphic(AssetPaths.bombup__png,true,32,32,false);
      
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