package unit.fish
{
    import starling.core.Starling;

    public class NimoFish extends BaseFish
    {
        [Embed(source='../media/textures/mc/nimoFish.png')]
        private static const __bmp:Class;
        [Embed(source="../media/textures/mc/nimoFish.xml", mimeType="application/octet-stream")]
        private static const __xml:Class;
        private static const __name:String = "nimoFish";
        
        public function NimoFish()
        {
        }
        
        public function initialization(x:int = 0,y:int = 0):void{
            createMovieclip(new __bmp,XML(new __xml),__name);
            movieClip.x = x;
            movieClip.y = y;
//            movieClip.stop();
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