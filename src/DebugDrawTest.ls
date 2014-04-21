package
{
    import loom.Application;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
    import loom2d.display.QuadBatch;
    import loom2d.textures.Texture;
    import loom2d.ui.SimpleLabel;

    import loom2d.math.Point;
    import DebugDraw.LineSprite;
    import DebugDraw.TriangleSprite;
    import DebugDraw.DebugDraw;

    public class DebugDrawTest extends Application
    {
        override public function run():void
        {
            // Comment out this line to turn off automatic scaling.
            stage.scaleMode = StageScaleMode.LETTERBOX;

            // Draw a line.
            var line:LineSprite = new LineSprite(0, 0, 215, 0);
            line.y = 25;
            stage.addChild(line);

            // Draw a triangle.
            var triangle:QuadBatch = DebugDraw.newTriangle(30, 50, 0x0000ff);
            triangle.x = 240;
            triangle.y = 25;
            triangle.rotation = Math.degToRad(90);
            stage.addChild(triangle);

            // Draw an outline over the top of it.
            var triangleOutline:QuadBatch = DebugDraw.newTriangleOutline(30, 50, 0xffff00);
            triangleOutline.x = 240;
            triangleOutline.y = 25;
            triangleOutline.rotation = Math.degToRad(90);
            stage.addChild(triangleOutline);

            // Draw a filled polygon.
            var filledPolyPoints:Vector.<Point> = [new Point(400, 300),
                                                   new Point(325, 250),
                                                   new Point(325, 200),
                                                   new Point(400, 100),
                                                   new Point(420, 50),
                                                   new Point(450, 75),
                                                   new Point(400, 150),
                                                   new Point(350, 250),
                                                   new Point(425, 300)];
            var filledPoly:QuadBatch = DebugDraw.newPolygon(filledPolyPoints, 0xff0000);
            stage.addChild(filledPoly);

            // Draw an outlined polygon.
            var outlinePolyPoints:Vector.<Point> = [new Point(240, 150),
                                                    new Point(175, 250),
                                                    new Point(240, 275),
                                                    new Point(300, 150)];
            var outlinePoly:QuadBatch = DebugDraw.newPolygonOutline(outlinePolyPoints, 0x00ff00);
            stage.addChild(outlinePoly);
        }
    }
}