package 
{   
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    import starling.core.Starling;
    
    import utils.Stats;
    
    [SWF(backgroundColor="0x000000",width="1024",height="768")] 
    public class Fish extends Sprite
    {
        private var mStarling:Starling;
        public function Fish():void{
            var stats:Stats = new Stats();
            addChild(stats);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true;
            
            mStarling = new Starling(MainGame, stage,new Rectangle(0,0,1024,768));
            mStarling.simulateMultitouch = false;
            mStarling.enableErrorChecking = false;
            mStarling.start();
            
        }
        
    }
}
