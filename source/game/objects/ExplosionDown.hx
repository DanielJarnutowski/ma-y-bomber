package game.objects;
//package haxe.ds;

import lime.utils.Float64Array;
import openfl.Vector;
import js.html.webgl.VertexArrayObject;
import flixel.math.FlxRect;
import flixel.addons.display.FlxSliceSprite;
import game.char.Bomb;


class ExplosionDown extends FlxSliceSprite {
    var cachedVertices:Vector<Float>;
    var bombangle:Float;
    var presentExplosionTimer = 3.0;
    
    public function new(rect:FlxRect) {
        super(AssetPaths.bomb_explosion__png, rect, 4, 4);
        cachedVertices = this.vertices;
        bombangle = 180.degToRad();
        
    }
            override public function update(elapsed:Float) {
                
                super.update(elapsed);
                if (cachedVertices.length == 0 && this.vertices != null
                    && this.vertices.length > 0) {
                    cachedVertices = this.vertices.copy();
                    //trace(cachedVertices);
                    //trace(this.vertices);
                    }
                for (index in 0...cachedVertices.length) {
                    
                    if ((index + 1) % 2 == 0) {
                        this.vertices[index] = cachedVertices[index
                            - 1] * Math.sin(bombangle)
                            + cachedVertices[index] * Math.cos(bombangle);
                    } else {
                        this.vertices[index] = cachedVertices[index] * Math.cos(bombangle)
                            - cachedVertices[index + 1] * Math.sin(bombangle);
                    }
                    
                } 
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

