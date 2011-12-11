package demo
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class FishUnit extends Sprite
	{
        private var cos:Number;
        private var sin:Number;
        private var radian:Number;
        private var degreeRate:Number;
        private var preX:Number;
        private var preY:Number;
        private var currentX:Number;
        private var currentY:Number;
        private var centerX:Number;
        private var centerY:Number;
        private var currentDegree:int;
        private var noDegreeX:Number;
        private var noDegreeY:Number;
        
        private var str:String;
        private var fish:Shape = new Shape;
		public function FishUnit()
		{
            fish.graphics.beginFill(0);
            fish.graphics.lineTo(10,30);
            fish.graphics.lineTo(-10,30);
            fish.graphics.lineTo(0,0);
            fish.graphics.endFill();
            addChild(fish);
		}
        
        public function setFlyData(obj:Object):void{
            for(str in obj){
                this[str] = obj[str];
//                trace(str,obj[str]);
            }
            
            trace(currentDegree)
            radian = currentDegree * Math.PI / 180
            currentX = noDegreeX * Math.cos(radian) - noDegreeY * Math.sin(radian);
            currentY = noDegreeY * Math.cos(radian) + noDegreeX * Math.sin(radian);
            
//            trace(currentX,currentY,currentDegree)
            radian = degreeRate * Math.PI / 180;
            cos = Math.cos(radian);
            sin = Math.sin(radian);
        }
        
        public function updateFrame():void{
            preX = currentX;
            preY = currentY;
            currentX = preX * cos - preY * sin;
            currentY = preY * cos + preX * sin;
            currentDegree = Math.atan2(currentY,currentX)*180/Math.PI;
            degreeRate > 0 ? currentDegree +=180:currentDegree -= 0;
            
            fish.x = currentX + centerX;
            fish.y = currentY + centerY;
            fish.rotation = currentDegree;
        }
	}
}