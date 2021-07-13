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
    
    public function new(rect:FlxRect,angle:Float) {
        super(AssetPaths.bomb_explosion__png, rect, 4, 4);
        cachedVertices = this.vertices;
    }
            override public function update(elapsed:Float) {
                super.update(elapsed);
                if (cachedVertices.length == 0 && this.vertices != null
                    && this.vertices.length > 0) {
                    cachedVertices = this.vertices.copy();
                    }
                for (index in 0...cachedVertices.length) {
                    if ((index + 1) % 2 == 0) {
                        this.vertices[index] = cachedVertices[index
                            - 1] * Math.sin(angle)
                            + cachedVertices[index] * Math.cos(angle);
                    } else {
                        this.vertices[index] = cachedVertices[index] * Math.cos(angle)
                            - cachedVertices[index + 1] * Math.sin(angle);
                    }
                } 
                //trace(cachedVertices);
}
            }
            
