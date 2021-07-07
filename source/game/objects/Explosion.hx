package game.objects;

import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import game.char.Bomb;

class Explosion extends FlxSliceSprite {
  
    
    public function new(rect:FlxRect) {
        super(AssetPaths.bomb_explosion__png, rect, 4, 4);
        super(AssetPaths.bomb_explosion__png, rect, 4, 4);
    }

    
  

}

