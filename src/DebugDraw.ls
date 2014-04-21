package DebugDraw
{
    import loom2d.display.DisplayObjectContainer;
    import loom2d.display.Quad;
    import loom2d.display.QuadBatch;
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

    public class TriangleSprite extends Quad
    {
        public function TriangleSprite(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int, color:int=0xffffff)
        {
            super(1, 1, color);
            setPoints(x1, y1, x2, y2, x3, y3);
        }

        private function setPoints(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int)
        {
            setVertexPosition(0, x1, y1);
            setVertexPosition(1, x1, y1);
            setVertexPosition(2, x2, y2);
            setVertexPosition(3, x3, y3);
        }
    }

    public class DebugDraw
    {
        public static function newPolygon(contourPoints:Vector.<Point>, color:int=0xffffff):QuadBatch
        {
            var poly:QuadBatch = new QuadBatch();
            var trianglePoints:Vector.<Point> = Triangulate.process(contourPoints);
            for (var i = 0; i < trianglePoints.length; i += 3)
            {
                var triangle = new TriangleSprite(trianglePoints[i].x, trianglePoints[i].y,
                                                  trianglePoints[i+1].x, trianglePoints[i+1].y,
                                                  trianglePoints[i+2].x, trianglePoints[i+2].y, color);
                poly.addQuad(triangle);
            }
            return poly;
        }

        public static function newPolygonOutline(contourPoints:Vector.<Point>, color:int=0xffffff):QuadBatch
        {
            var poly:QuadBatch = new QuadBatch();
            var p1:Number;
            var p2:Number;
            for (var i = 0; i < contourPoints.length; ++i)
            {
                p1 = i;
                p2 = (i+1) % contourPoints.length;
                var newLine = new LineSprite(contourPoints[p1].x, contourPoints[p1].y,
                                             contourPoints[p2].x, contourPoints[p2].y, color);
                poly.addQuad(newLine);
            }
            return poly;
        }

        public static function newTriangle(width:Number, height:Number=0.0, color:int=0xffffff):QuadBatch
        {
            return newPolygon(makeTrianglePoints(width, height), color);
        }

        public static function newTriangleOutline(width:Number, height:Number=0.0, color:int=0xffffff):QuadBatch
        {
            return newPolygonOutline(makeTrianglePoints(width, height), color);
        }

        private static function makeTrianglePoints(width:Number, height:Number=0.0):Vector.<Point>
        {
            Debug.assert(width > 0.0, "You need to specify a positive height for your triangle!");
            if (height <= 0.0)
            {
                height = width;
            }
            var halfWidth = width/2.0;
            var halfHeight = height/2.0;

            var points:Vector.<Point> = new Vector.<Point>();
            points.pushSingle(new Point(0, -halfHeight));
            points.pushSingle(new Point(-halfWidth, halfHeight));
            points.pushSingle(new Point(halfWidth, halfHeight));
            return points;
        }
    }
}