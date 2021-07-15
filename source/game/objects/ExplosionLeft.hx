package game.objects;

import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import game.char.Bomb;

class ExplosionLeft extends FlxSliceSprite {
    var presentExplosionTimer = 3.0;
  
    
    public function new(rect:FlxRect) {
        super(AssetPaths.bomb_explosion__png, rect, 4, 4);
    }

    override public function update(elapsed:Float) {
        if(presentExplosionTimer>=0)
            {
                presentExplosionTimer= presentExplosionTimer- elapsed;  
                  
    
            }             
            if(presentExplosionTimer<=0)
                {
                    this.kill();
                }
}
}


            
