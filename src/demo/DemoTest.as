package demo
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.filters.BlurFilter;
    import flash.geom.Rectangle;
    
    
    public class DemoTest extends Sprite
    {
     
        [Embed(source='../media/demo/fish.png')]
        private static const _fish:Class;
        
        [Embed(source='../media/demo/fire.png')]
        private static const _fire:Class;

        
        private var fish:Bitmap;
        private var fire:Bitmap;
        
        private var fishC:Sprite = new Sprite;
        private var fireC:Sprite = new Sprite;
        
        private var fishR:Rectangle;
        private var fireR:Rectangle;
        private var trueBorder:Shape = new Shape;
        public function DemoTest(){
            
            fish = new _fish;
            fire = new _fire;
            
            fireC.addChild(fire);
            fishC.addChild(fish);
            
            addChild(fishC);
            addChild(fireC);
            
           
            
            this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            fish.rotation = 30;
            fish.x = stage.stageWidth >>1;
            fish.y = stage.stageHeight >>1;
            trueBorder.graphics.lineStyle(2,0xff0000);
            trueBorder.graphics.drawRect(0,0,fish.bitmapData.width,fish.bitmapData.height);
            addChild(trueBorder);
            trueBorder.x = fish.x;
            trueBorder.y = fish.y;
        }
        
        
        
        protected function onEnterFrame(event:Event):void
        {
            // TODO Auto-generated method stub
            fire.x = this.mouseX;
            fire.y = this.mouseY;
            
            fireR = fire.getBounds(fireC);
            drawBound(fireC,fireR);
            
            fishR = fish.getBounds(fishC);
            drawBound(fishC,fishR);
            fish.rotation += 1;
            trueBorder.rotation = fish.rotation;
//            trace("fireR",fireR,"fishR",fishR)
            if(fireR.intersects(fishR)){
                fishC.filters = [new BlurFilter]
            }else{
                fishC.filters = null;
            }
        }        
        
        private function drawBound(target:Sprite,rect:Rectangle):void{
            target.graphics.clear();
            target.graphics.lineStyle(1);
            target.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
            
        }
    }
}