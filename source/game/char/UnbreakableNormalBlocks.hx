package game.char;



class UnbreakableNormalBlocks extends Unbreakable

{
    public static var unbreakableNormalBlocks = 'unbreakableNormalBlocks';
    
    public function new(x,y) {
        super(x,y);
        this.loadGraphic(AssetPaths.mytileset__png,true,32,32,false);
        //paramters, location, animated, x,y,unique
        animation.add(unbreakableNormalBlocks,[4],1,true);
        animation.play(unbreakableNormalBlocks);
    }

    

}