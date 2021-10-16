package game.ext;

import lime.math.Vector2;
import flixel.FlxObject;
class UiComponent extends FlxTypedGroup<UiComponent>
{
//public var position:Vector2;


function move(group:FlxTypedGroup<FlxSprite>, position:FlxPoint, x:Float,
    y:Float) {
group.members.iter((member) -> {
    var currentPosition = member.getPosition();
    var newPosition = new FlxPoint(x, y);
    newPosition.putWeak();
    var diffPosition = newPosition.subtractPoint(currentPosition);
    // Adjust the relative components by the new position of the container
    var relativeX = currentPosition.x - position.x;
    var relativeY = currentPosition.y - position.y;
    member.x += diffPosition.x + relativeX;
    member.y += diffPosition.y + relativeY;
});
position.set(x, y);
}

}

