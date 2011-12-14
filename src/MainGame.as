package
{
    import com.FishFacatory;
    
    import data.GlobalData;
    
    import flash.display.Bitmap;
    import flash.utils.getTimer;
    
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    
    import unit.fish.NimoFish;
    import unit.gun.Gun;
    
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
        
        public var gameData:GlobalData = new GlobalData();
        private var gun:Gun = new Gun;
        
        private var fishFacatory:FishFacatory = new FishFacatory();

        public function MainGame()
        {
            addEventListener(Event.ADDED_TO_STAGE,onAdded);
            
        }
        
        private function updateFrame(e:Event):void
        {
            gameData.nowTime = getTimer();
            gun.updateFrame();
            fishFacatory.updateFrame();
        }
        
        private var fish:NimoFish = new NimoFish();
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
            fish.initialization();
            addChild(fish);
            
            fishFacatory.initialization(this);
        }
        
        private function onTouch(e:TouchEvent):void{
            var t:Touch = e.getTouch(stage);
            gameData.globalMouseX = t.globalX;
            gameData.globalMouseY = t.globalY;
            if(t.phase == TouchPhase.BEGAN){
                gun.fire();
            }
            else if(t.phase == TouchPhase.ENDED){
                gun.stop();
            }
            
        }
        
        
        
        
        
    }
}