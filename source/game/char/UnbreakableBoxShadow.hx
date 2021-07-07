package game.char;
import game.char.Unbreakable;


class UnbreakableBoxShadow extends Unbreakable

{
    public static var unbreakableBoxShadow = 'unbreakableBoxShadow';
    
    public function new(x,y) {
        super(x,y);
        this.loadGraphic(AssetPaths.mytileset__png,true,32,32,false);
        //paramters, location, animated, x,y,unique
        animation.add(unbreakableBoxShadow,[0],1,true);
        animation.play(unbreakableBoxShadow);
    }

    

}