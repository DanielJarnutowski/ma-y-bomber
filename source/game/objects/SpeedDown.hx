package game.objects;

class SpeedDown  extends FlxSprite
{

public function new (x,y)
    {
        super(x,y);
        loadGraphic(AssetPaths.speeddown__png,true,16,16,false);
      
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
         
    }

}