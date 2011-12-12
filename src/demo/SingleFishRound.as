package demo
{
    import com.bit101.components.InputText;
    import com.bit101.components.Label;
    
    import flash.display.Sprite;
    import flash.events.*;
    import flash.filters.BlurFilter;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    
    import starling.display.Button;
    
    import utils.CollisionDetection;

    public class SingleFishRound extends Sprite
    {
        private var fish:Sprite = new Sprite;
        private var increaseDegree:Number = 1;
        
        private var cos:Number;
        private var sin:Number;
        private var radias:Number;
        
        private var preX:Number;
        private var preY:Number;
        private var currentX:Number;
        private var currentY:Number;
        private var centerX:Number;
        private var centerY:Number;
        private var currentAngle:int;
        
        private var data:Vector.<Object> = Vector.<Object>([
            {label:"CenterX",v:"110",t:"centerX",h:changeValue},
            {label:"CenterY",v:"110",t:"centerY",h:changeValue},
            {label:"CurrentX",v:"50",t:"currentX",h:changeValue},
            {label:"CurrentY",v:"0",t:"currentY",h:changeValue},
            {label:"DegreeRate",v:1,t:"increaseDegree",h:changeValue},
            {label:"BulletRotation",v:0,t:"bulletRotation",h:changeBulletRotation}
        ]);
        //            {label:"DegreeRate",v:"1",t:"nn",h:changeValue}
//        private var dataLock:Boolean = false;
        private var dic:Dictionary = new Dictionary;
        private var m:Matrix = new Matrix;

        private var bullet:Bullet;
        private var bulletRotation:Number;
        private var collisionDetection:CollisionDetection = new CollisionDetection;
        private var fishRec:Rectangle = new Rectangle;
        public function SingleFishRound()
        {
            createUI();
            initData();
            this.graphics.moveTo(centerX,centerY);
            this.graphics.lineStyle(1);
            
            fish.graphics.beginFill(0);
//            fish.graphics.lineTo(10,30);
//            fish.graphics.lineTo(-10,30);
//            fish.graphics.lineTo(0,0);
//            fish.graphics.endFill();
            fish.graphics.drawRect(0,0,20,40);
            addChild(fish);
            fishRec.width = 20;
            fishRec.height = 40;
            
            bullet = new Bullet();
            addChild(bullet);
            
//            m.rotate(Math.PI/180);
//            fish.rotation = 90;
            this.addEventListener(Event.ENTER_FRAME,updateFrame);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onM);
        }
		
		protected function onM(event:MouseEvent):void
		{
			//不用radian的原因在于其无法指出方向
//			if(collisionDetection.collisionDetect(bullet.unrotatedRect,bullet.radian,fishRec,currentAngle *Math.PI/180,4))
            if(collisionDetection.collisionDetect(bullet.unrotatedRect,bullet.radian,fishRec,currentAngle *Math.PI/180) ||collisionDetection.collisionDetect(fishRec,currentAngle *Math.PI/180,bullet.unrotatedRect,bullet.radian))
			{
				fish.filters = [new GlowFilter];
			}else{
				fish.filters = null;
			}
		}
		
        private function changeBulletRotation(e:Event):void{
            bullet.setRotation(e.target.text);
        }
        
        /** 创建交互UI*/
        private function createUI():void
        {
            var uiContainer:Sprite = new Sprite();
            var i:int = 0;
            for each (var o:Object in data){
                var label:Label = new Label(uiContainer,0,20*i++,o.label);
                var inputText:InputText = new InputText(uiContainer,label.x+60,label.y,o.v,o.h);
                inputText.name = o.label;
                dic[inputText.name] = inputText;
            }
            addChild(uiContainer);
            uiContainer.x = 300;
            
        }
        
        /**初始化数据*/
        private function initData():void{
            for each(var o:Object in data){
                this[o.t] = o.v;
            }
            setDegree();
        }
        
        /** 更改数据*/
        private function changeValue(e:Event):void{
//            dataLock = true;
//            for each (var o:Object in data){
//                if(o.label == e.target.name){
//                    this[o.t] = e.target.text;
//                    this.graphics.clear();
//                    this.graphics.lineStyle(1);
//                    this.graphics.moveTo(centerX,centerY);
//                    trace(currentY,currentX)
//                    break;
//                }
//            }
//            dataLock = false;
            for each (var o:Object in data){
                this[o.t] = dic[o.label].text;
            }
            setDegree();
//            this.graphics.clear();
            this.graphics.lineStyle(1);
            this.graphics.moveTo(centerX,centerY);
        }
        
        private function setDegree():void{
            radias = increaseDegree * Math.PI / 180;
            cos = Math.cos(radias);
            sin = Math.sin(radias);
        }
        protected function updateFrame(event:Event):void
        {
            preX = currentX;
            preY = currentY;
            currentX = preX * cos - preY * sin;
            currentY = preY * cos + preX * sin;
            fish.x = currentX + centerX;
            fish.y = currentY + centerY;
            this.graphics.lineTo(fish.x,fish.y);
            radias = Math.atan2(currentY,currentX);
            currentAngle = radias*180/Math.PI;
            increaseDegree > 0 ? currentAngle +=180:currentAngle -= 0
            fish.rotation = currentAngle;
//            dic["CurrentX"].text = currentX
//                trace("currentY",currentY,"centerY",centerY)//,"fish.y",fish.y)
            
            fishRec.x = fish.x
            fishRec.y = fish.y;   
            bullet.setXY(this.mouseX,this.mouseY);
//            trace(collisionDetection.collisionDetect(bullet.unrotatedRect,bullet.radian,fishRec,radias))
        }
    }
}