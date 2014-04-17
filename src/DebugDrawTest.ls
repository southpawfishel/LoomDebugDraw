package
{
    import loom.Application;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
    import loom2d.textures.Texture;
    import loom2d.ui.SimpleLabel;

    import loom2d.math.Point;
    import DebugDraw.LineSprite;
    import DebugDraw.PolygonSprite;
    import DebugDraw.FilledPolygonSprite;

    public class DebugDrawTest extends Application
    {
        override public function run():void
        {
            // Comment out this line to turn off automatic scaling.
            stage.scaleMode = StageScaleMode.LETTERBOX;

            // Draw a line.
            var line:LineSprite = new LineSprite(100, 75, 150, 300);
            stage.addChild(line);

            // Draw an outlined polygon.
            var outlinePolyPoints:Vector.<Point> = [new Point(240, 150),
                                                    new Point(175, 250),
                                                    new Point(240, 275),
                                                    new Point(300, 150)];
            var outlinePoly:PolygonSprite = new PolygonSprite(outlinePolyPoints, 0x00ff00);
            stage.addChild(outlinePoly);

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
            var filledPoly:FilledPolygonSprite = new FilledPolygonSprite(filledPolyPoints, 0xff0000);
            stage.addChild(filledPoly);

        }
    }
}