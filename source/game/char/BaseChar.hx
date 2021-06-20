import game.GameTypes.PlayerType;




class BaseChar extends FlxSprite   {
    var speed = 96;
    
    
public function playerOneMovement(controller: PlayerType)
    {
            if (controller == PlayerOne)
                { 
                if(FlxG.keys.pressed.UP)
                    {
                        this.velocity.x= 0;
                        this.velocity.y = 96;
                    }

                if(FlxG.keys.pressed.DOWN)
                    {
                        this.velocity.x = 0;
                        this.velocity.y = -96;
                    }

                if(FlxG.keys.pressed.LEFT)
                    {
                        this.velocity.x = -96;
                        this.velocity.y = 0;
                    }

                if(FlxG.keys.pressed.RIGHT)
                     {
                        this.velocity.x = 96;
                        this.velocity.y = 0;
                     }

                }
    }











}