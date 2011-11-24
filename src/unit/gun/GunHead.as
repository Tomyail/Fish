package unit.gun
{
    import flashx.textLayout.accessibility.TextAccImpl;
    
    import starling.core.Starling;
    import starling.display.MovieClip;
    
    import utils.FrameGenerator;
    import unit.BaseMovieClip;

    public class GunHead extends BaseMovieClip
    {
        [Embed(source='../media/textures/mc/gunmouth1.png')]
        private static const __bmp:Class;
        [Embed(source="../media/textures/mc/gunmouth1.xml", mimeType="application/octet-stream")]
        private static const __xml:Class;
        private static const __name:String = "gunmouth5";
        
        public function GunHead()
        {
        }
        
        public function initialization(x:int = 0,y:int = 0):void{
            createMovieclip(new __bmp,XML(new __xml),__name);
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