package unit.fish
{
    import starling.core.Starling;

    public class NimoFish extends BaseFish
    {
        [Embed(source='../media/textures/mc/nets.png')]
        private static const __bmp:Class;
        [Embed(source="../media/textures/mc/nets.xml", mimeType="application/octet-stream")]
        private static const __xml:Class;
        private static const __name:String = "nets";
        
        public function NimoFish()
        {
        }
        
        public function initialization(x:int = 30,y:int = 30):void{
            createMovieclip(new __bmp,XML(new __xml),__name);
            movieClip.x = x;
            movieClip.y = y;
//            movieClip.stop();
            addChild(movieClip);
            Starling.juggler.add(movieClip);
        }
        
        //test
        public function changeTextures():void{
            super.changeTexture();
        }
        
        public function play():void{
            movieClip.play();
        }
        public function stop():void{
            movieClip.stop();
        }
    }
}