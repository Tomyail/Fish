package
{
    import com.FishFacatory;
    import com.Proxy;
    
    import data.GlobalData;
    
    import flash.display.Bitmap;
    import flash.utils.getTimer;
    
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    
    import unit.fish.NimoFish;
    import unit.gunGroup.GunGroup;
    import unit.scorePanel.ScorePanel;
    
    public class MainGame extends Sprite
    {
        public var gameData:GlobalData = new GlobalData();
        private var fishFacatory:FishFacatory = new FishFacatory();
        private var gunGroup:GunGroup = new GunGroup;
        public var cdm:Proxy = new Proxy();
        
        [Embed(source = "../media/textures/button_big.png")]
        private static const ButtonBig:Class;
        [Embed(source = "../media/textures/main_bg.png")]
        private static const MainBg:Class;
        [Embed(source = "../media/textures/bg.png")]
        private static const Bg:Class;
        
        private var mainBg:Image;
        private var bg:Image;
        private var button:Button;
        
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
            if(gameData.downFlag && gameData.nowTime - gunGroup.lastFireTime> 300){
                gunGroup.startFire(gameData.globalMouseX,gameData.globalMouseY);
            }else if(!gameData.downFlag){
                gunGroup.stopFire();
            }
//            this.unflatten();
        }
        
        private function onAdded(e:Event):void
        {
            configMainScence();
        }
        
        private function configListener():void{
            stage.addEventListener(TouchEvent.TOUCH,onTouch);
            stage.addEventListener(Event.ENTER_FRAME,updateFrame);
        }
        
        private function initialization():void
        {
            configMainScence();
        }
        
        private function configMainScence():void{
            mainBg = new Image(Texture.fromBitmap(new MainBg));
            button = new Button(Texture.fromBitmap(new ButtonBig),"进入游戏");
            addChild(mainBg);
            addChild(button);
            button.x = stage.stageWidth - button.width >>1;
            button.y = stage.stageHeight - button.height >>1;
            button.addEventListener(Event.TRIGGERED,onTriggered);
        }
        
        private function onTriggered(e:Event):void
        {
            // TODO Auto Generated method stub
            button.removeEventListener(Event.TRIGGERED,onTriggered);
            removeChild(mainBg);
            removeChild(button);
            
            bg = new Image(Texture.fromBitmap(new Bg));
            addChild(bg);
            
            
            gunGroup.initialization(this,null);
            fishFacatory.initialization(this);
            cdm.initialization(fishFacatory.fishPoolManager,gunGroup);
            configListener();
        }
        private function onTouch(e:TouchEvent):void{
            var t:Touch = e.getTouch(stage);
            gameData.globalMouseX = t.globalX;
            gameData.globalMouseY = t.globalY;
            
            if(t.phase == TouchPhase.BEGAN){
                gameData.downFlag = true;
            }
            else if(t.phase == TouchPhase.ENDED){
                gameData.downFlag = false
            }
            
        }
    }
}