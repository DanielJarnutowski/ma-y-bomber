package game.char;


class UnbreakableBlocks extends FlxSprite

{
    public static var unbreakable = 'unbreakable';
    
    public function new(x,y) {
        super(x,y);
        this.loadGraphic(AssetPaths.bomberman_tileset__png,true,32,32,false);
        //paramters, location, animated, x,y,unique
        animation.add(unbreakable,[2],1,true);
        animation.play(unbreakable);
    }

    

}