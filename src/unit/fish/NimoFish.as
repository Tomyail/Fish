package unit.fish
{
    import starling.core.Starling;
    import starling.display.MovieClip;

    import utils.FrameGenerator;
    public class NimoFish extends BaseFish
    {
        [Embed(source='../media/textures/mc/nimoFish.png')]
        private static const __bmp:Class;
        [Embed(source="../media/textures/mc/nimoFish.xml", mimeType="application/octet-stream")]
        private static const __xml:Class;
        private static const __name:String = "nimoFish";
        
        public function NimoFish()
        {
            this.name = "nimo";
        }
        
        override public function initialization():void{
            frames = FrameGenerator.generateFrame(new __bmp,XML(new __xml),__name);
            fish = new MovieClip(frames);
            addChild(fish);
            fish.stop();
            Starling.juggler.add(fish);
        }
        
    }
}