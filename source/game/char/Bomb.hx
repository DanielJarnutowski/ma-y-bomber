package game.char;

class Bomb extends FlxSprite

{

    public function new (x,y)
        {
            super(x,y);
            //bomb graphic is temporary Kino will get a new graphic later
            loadGraphic(AssetPaths.bomb_icon_pixel_art_danger_concept_77986701_removebg_preview__png,true,32,32,false);
            //makeGraphic(32,32,FlxColor.RED);
        }

      











}