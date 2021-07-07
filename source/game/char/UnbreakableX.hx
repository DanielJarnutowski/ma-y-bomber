package game.char;
import game.char.Unbreakable;

class UnbreakableX extends Unbreakable

{
    public static var unbreakableX = 'unbreakableX';
    
    public function new(x,y) {
        super(x,y);
        this.loadGraphic(AssetPaths.mytileset__png,true,32,32,false);
        //paramters, location, animated, x,y,unique
        animation.add(unbreakableX,[1],1,true);
        animation.play(unbreakableX);
    }

    

}