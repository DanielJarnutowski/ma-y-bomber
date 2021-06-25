package game.char;
import flixel.graphics.frames.FlxAtlasFrames;
import game.GameTypes.PlayerType;
class BaseChar extends FlxSprite   {
    public var speed = 460;   
    public var controller: PlayerType;
    public var moveToNextTile = false;
    public var previousPosition : FlxPoint;
    public var charDirection: CharDirection;

    public function new (controller:PlayerType,x:Float, y:Float)
        {
            this.controller = controller;
            super(x,y);
        }

        override public function update(elapsed: Float)
            {
                super.update(elapsed);
                updateMovement(elapsed);
                playerMovement(controller);
                this.bound();
            }

            public function updateMovement(elapsed:Float) {
                if (moveToNextTile) {
                    switch (charDirection) {
                        case Up:
                            y -= Globals.MOVEMENT_SPEED;
                        case Down:
                            y += Globals.MOVEMENT_SPEED;
                        case Left:
                            x -= Globals.MOVEMENT_SPEED;
                        case Right:
                            x += Globals.MOVEMENT_SPEED;
                    }
                }

                if ((x % Globals.TILE_SIZE == 0) && (y % Globals.TILE_SIZE == 0)) {
                    moveToNextTile = false;
                    previousPosition = this.getPosition();
                }
            }
        
            public function moveTo(direction:CharDirection) {
                if (!moveToNextTile) {
                    charDirection= direction;
                    moveToNextTile = true;
                }
            }
        
            public function resetPosition() {
                if (previousPosition != null) {
                    this.setPosition(previousPosition.x, previousPosition.y);
                }
            }


public function playerMovement(controller: PlayerType)// add playertwo functionality 
    {
            if (controller == PlayerOne)
                { 
                if(FlxG.keys.pressed.UP)
                    {
                        moveTo(CharDirection.Up);
                        //this.velocity.x= 0;
                       // this.velocity.y = -speed;
                    }

                if(FlxG.keys.pressed.DOWN)
                    {
                        moveTo(CharDirection.Down);
                       // this.velocity.x = 0;
                       // this.velocity.y = speed;
                    }

                if(FlxG.keys.pressed.LEFT)
                    {
                        moveTo(CharDirection.Left);
                        //this.velocity.x = -speed;
                       // this.velocity.y = 0;
                    }

                if(FlxG.keys.pressed.RIGHT)
                     {
                        moveTo(CharDirection.Right);
                       // this.velocity.x = speed;
                        //this.velocity.y = 0;
                     }

                }

                if (controller == PlayerTwo)
                    { 
                    if(FlxG.keys.pressed.I)
                        {
                            moveTo(CharDirection.Up);
                           // this.velocity.x= 0;
                            //this.velocity.y = -speed;
                        }
    
                    if(FlxG.keys.pressed.K)
                        {
                            moveTo(CharDirection.Down);
                           // this.velocity.x = 0;
                          //  this.velocity.y = speed;
                        }
    
                    if(FlxG.keys.pressed.J)
                        {
                            moveTo(CharDirection.Left);
                           // this.velocity.x = -speed;
                           // this.velocity.y = 0;
                        }
    
                    if(FlxG.keys.pressed.L)
                         {
                            moveTo(CharDirection.Right);
                           // this.velocity.x = speed;
                           // this.velocity.y = 0;
                         }
    
                    }
    }

    //public Basechar(x,y, PlayerType) //location of characters
    //{

    //}
    

}