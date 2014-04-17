package DebugDraw
{
    import loom2d.display.DisplayObjectContainer;
    import loom2d.display.Quad;
    import loom2d.display.QuadBatch;
    import loom2d.display.Sprite;
    import loom2d.math.Point;

    public class LineSprite extends Quad
    {
        public function LineSprite(x1:int, y1:int, x2:int, y2:int, color:int=0xffffff)
        {
            super(1, 1, color);
            setPoints(x1, y1, x2, y2);
        }

        public function setPoints(x1:int, y1:int, x2:int, y2:int)
        {
            // Horizontal case
            if (y1 == y2)
            {
                setVertexPosition(0, x1, y1-1);
                setVertexPosition(1, x2, y1-1);
                setVertexPosition(2, x1, y2+1);
                setVertexPosition(3, x2, y2+1);
            }
            // Vertical
            else if (x1 == x2)
            {
                setVertexPosition(0, x1-1, y1);
                setVertexPosition(1, x2+1, y1);
                setVertexPosition(2, x1-1, y2);
                setVertexPosition(3, x2+1, y2);
            }
            // Up and to the right
            else if (x1 < x2 && y1 < y2 || x1 > x2 && y1 > y2)
            {
                setVertexPosition(0, x1+1, y1);
                setVertexPosition(1, x1, y1+1);
                setVertexPosition(2, x2+1, y2);
                setVertexPosition(3, x2, y2+1);
            }
            // Down and to the right
            else
            {
                setVertexPosition(0, x1, y1);
                setVertexPosition(1, x1+1, y1+1);
                setVertexPosition(2, x2, y2);
                setVertexPosition(3, x2+1, y2+1);
            }
        }
    }

    private class TriangleSprite extends Quad
    {
        public function TriangleSprite(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int, color:int=0xffffff)
        {
            super(1, 1, color);
            setVertexPosition(0, x1, y1);
            setVertexPosition(1, x1, y1);
            setVertexPosition(2, x2, y2);
            setVertexPosition(3, x3, y3);
        }
    }

    public class PolygonSprite extends Sprite
    {
        public function PolygonSprite(contourPoints:Vector.<Point>, color:int=0xffffff):void
        {
            var p1:Number;
            var p2:Number;
            for (var i = 0; i < contourPoints.length; ++i)
            {
                p1 = i;
                p2 = (i+1) % contourPoints.length;
                var newLine = new LineSprite(contourPoints[p1].x, contourPoints[p1].y,
                                             contourPoints[p2].x, contourPoints[p2].y, color);
                addChild(newLine);
            }
        }
    }

    public class FilledPolygonSprite extends Sprite
    {
        public function FilledPolygonSprite(contourPoints:Vector.<Point>, color:int=0xffffff):void
        {
            var trianglePoints:Vector.<Point> = Triangulate.process(contourPoints);
            for (var i = 0; i < trianglePoints.length; i += 3)
            {
                var triangle = new TriangleSprite(trianglePoints[i].x, trianglePoints[i].y,
                                                  trianglePoints[i+1].x, trianglePoints[i+1].y,
                                                  trianglePoints[i+2].x, trianglePoints[i+2].y, color);
                addChild(triangle);
            }
        }
    }
}