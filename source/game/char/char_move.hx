package game.char;

import js.html.KeyEvent;


class Char_mov   {

public function player_Movement(character_type: String)
    {
            if (character_type == 'player')
                {
                    var default_speed = 0; 
                    var x_Speed = 0;
                    var y_Speed = 0;
                   
                if(FlxG.keys.pressed.UP)
                    {
                        x_Speed = 0;
                        y_Speed = 96;
                    }

                if(FlxG.keys.pressed.DOWN)
                    {
                        x_Speed = 0;
                        y_Speed = -96;
                    }

                if(FlxG.keys.pressed.LEFT)
                    {
                        x_Speed = -96;
                        y_Speed = 0;
                    }

                if(FlxG.keys.pressed.RIGHT)
                     {
                        x_Speed = 96;
                        y_Speed = 0;
                     }

                }
    }











}