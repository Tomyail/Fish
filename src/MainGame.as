package
{
    import com.Proxy;
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
    import unit.gunGroup.GunGroup;
    import unit.scorePanel.ScorePanel;
    
    public class MainGame extends Sprite
    {
        public var gameData:GlobalData = new GlobalData();
        private var fishFacatory:FishFacatory = new FishFacatory();
        private var gunGroup:GunGroup = new GunGroup;
        public var cdm:Proxy = new Proxy();
        
        public function MainGame()
        {
            addEventListener(Event.ADDED_TO_STAGE,onAdded);
            
        }
        
        private function updateFrame(e:Event):void
        {
//            this.flatten();
            gameData.nowTime = getTimer();
            fishFacatory.updateFrame();
            gunGroup.updateFrame();
//            this.unflatten();
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
            gunGroup.initialization(this,null);
            fishFacatory.initialization(this);
            cdm.initialization(fishFacatory.fishPoolManager,gunGroup);
        }
        
        private function onTouch(e:TouchEvent):void{
            var t:Touch = e.getTouch(stage);
            gameData.globalMouseX = t.globalX;
            gameData.globalMouseY = t.globalY;
            if(t.phase == TouchPhase.BEGAN){
                gunGroup.startFire(t.globalX,t.globalY);
            }
            else if(t.phase == TouchPhase.ENDED){
                gunGroup.stopFire();
            }
            
        }
    }
}