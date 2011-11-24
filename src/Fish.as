package 
{   
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    
    import starling.core.Starling;
    
    public class Fish extends Sprite
    {
        private var mStarling:Starling;
        public function Fish():void{
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true;
            
            mStarling = new Starling(MainGame, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = false;
            mStarling.start();
            
        }
        
    }
}
