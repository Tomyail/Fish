package unit.gunGroup.gun
{
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    import utils.FrameGenerator;

    public class GunBody extends Sprite
    {
        [Embed(source='../media/textures/mc/gunbody.png')]
        private static const __bmp:Class;
        [Embed(source="../media/textures/mc/gunbody.xml", mimeType="application/octet-stream")]
        private static const __xml:Class;
        private static const __name:String = "gunbody";
        private var frames:Vector.<Texture>;
        private var movieClip:MovieClip;
        
        public function GunBody()
        {
        }
        
        public function initialization(x:int = 0,y:int = 0):void{
            frames = FrameGenerator.generateFrame(new __bmp,XML(new __xml),__name);
            movieClip = new MovieClip(frames);
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