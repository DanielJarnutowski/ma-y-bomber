package game.char;


class BreakableBlocks extends FlxSprite

{
    public static var breakable = 'breakable';
    
    public function new(x,y) {
        super(x,y);
        this.loadGraphic(AssetPaths.bomberman_tileset__png,true,32,32,false);
        //paramters, location, animated, x,y,unique
        animation.add(breakable,[3],1,true);
        animation.play(breakable);
    }

    

}