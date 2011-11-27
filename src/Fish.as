package 
{   
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    import starling.core.Starling;
    
    [SWF(backgroundColor="0x000000",width="800",height="600")] 
    public class Fish extends Sprite
    {
        private var mStarling:Starling;
        public function Fish():void{
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true;
            
            mStarling = new Starling(MainGame, stage,new Rectangle(0,0,800,600));
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = false;
            mStarling.start();
            
        }
        
    }
}
