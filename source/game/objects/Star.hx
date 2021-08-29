package game.objects;

class Star  extends FlxSprite
{

public function new (x,y)
    {
        super(x,y);
        loadGraphic(AssetPaths.star__png,true,32,32,false);
      
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
         
    }

}