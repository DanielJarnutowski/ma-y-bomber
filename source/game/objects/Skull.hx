package game.objects;

class Skull  extends Collectible
{
    public var timer = 4.0;
public function new (x,y)
    {
        super(x,y);
        loadGraphic(AssetPaths.skull__png,true,32,32,false);
      
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
        if(timer<1.0)
            {
                this.visible=true;
               this.solid= true;
               
            }

         
    }

}