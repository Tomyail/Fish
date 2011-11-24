package
{
    import flash.display.Bitmap;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    
    import unit.fish.NimoFish;
    import unit.gun.Gun;
    import unit.gun.GunBody;
    import unit.gun.GunHead;
    
    public class MainGame extends Sprite
    {
        [Embed(source='../media/textures/fish/yellowFish.png')]
        private static const YellowFish:Class;
        [Embed(source="../media/textures/fish/yellowFish.xml", mimeType="application/octet-stream")]
        private static const YellowFishXML:Class;
        
        private var bmp:Bitmap;
        private var yellowFish:Image;
        private var xml:XML;
        private var yellowFishMc:MovieClip;
        
        private var gun:Gun = new Gun;

        public var globalMouseX:Number = 0;
        public var globalMouseY:Number = 0
        public function MainGame()
        {
            addEventListener(Event.ADDED_TO_STAGE,onAdded);
            
        }
        
        private function updateFrame(e:Event):void
        {
            // TODO Auto Generated method stub
            
            gun.updateFrame();
        }
        
        private function onAdded(e:Event):void
        {
           
            
            configListener()
            
            initialization();
        }
        
        private function configListener():void{
            stage.addEventListener(TouchEvent.TOUCH,onTouch);
            stage.addEventListener(Event.ENTER_FRAME,updateFrame);
        }
        
        private function initialization():void
        {
            gun.initialization(this);
        }
        
        private function onTouch(e:TouchEvent):void{
            var t:Touch = e.getTouch(stage);
            globalMouseX = t.globalX;
            globalMouseY = t.globalY;
            if(t.phase == TouchPhase.BEGAN){
                gun.fire()
            }
            else if(t.phase == TouchPhase.ENDED){
                gun.stop();
            }
            
        }
        
        
        
        
        
    }
}