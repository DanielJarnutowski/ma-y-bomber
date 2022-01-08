package game.ext;

import flixel.util.FlxPath;

class PathExt {
  public static inline function activePathNode(path:FlxPath):FlxPoint {
    var currentPoint = path.nodes[path.nodeIndex];
    return currentPoint;
  }
}