package unit.gun
{
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    import utils.FrameGenerator;

    public class GunHead extends Sprite
    {
        [Embed(source='../media/textures/mc/gunmouth1.png')]
        private static const __bmp:Class;
        [Embed(source="../media/textures/mc/gunmouth1.xml", mimeType="application/octet-stream")]
        private static const __xml:Class;
        private static const __name:String = "gunmouth1";
        private var frames:Vector.<Texture>;
        private var movieClip:MovieClip;
        
        public function GunHead()
        {
        }
        
        public function initialization(x:int = 0,y:int = 0):void{
            frames = FrameGenerator.generateFrame(new __bmp,XML(new __xml),__name);
            movieClip = new MovieClip(frames);
            movieClip.pivotX = movieClip.width >>1;
            movieClip.pivotY = movieClip.height >>1;
            movieClip.x = x;
            movieClip.y = y;
            movieClip.stop();
            addChild(movieClip);
            Starling.juggler.add(movieClip);
        }
        
        public function play():void{
            movieClip.play();
        }
        public function stop():void{
            movieClip.stop();
        }
    }
}