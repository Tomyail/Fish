package unit.fish
{
    import flash.display.Bitmap;
    
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    import unit.BaseMovieClip;
    
    public class BaseFish extends Sprite
    {
        protected var str:String;
        protected var radian:Number;
        protected var currentDegree:Number;
        protected var currentX:Number;
        protected var currentY:Number;
        protected var degreeRate:Number;
        protected var cos:Number;
        protected var sin:Number;
        protected var noDegreeX:Number;
        protected var noDegreeY:Number;
        protected var preX:Number;
        protected var preY:Number;
        protected var centerX:Number;
        protected var centerY:Number;
        
        protected var fish:MovieClip;
        protected var frames:Vector.<Texture>;
        public function BaseFish()
        {
        }
        
        public function initialization():void{
            throw new Error("please override...")
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
            fish.rotation = currentDegree * Math.PI/180;
        }
        
        public function play():void{
            fish.play();
        }
        
        public function pause():void{
            fish.pause();
        }
        
        public function setFlyData(obj:Object):void{
            for(str in obj){
                this[str] = obj[str];
//                trace(str,obj[str]);
            }
            
//            trace(currentDegree)
            radian = currentDegree * Math.PI / 180
            currentX = noDegreeX * Math.cos(radian) - noDegreeY * Math.sin(radian);
            currentY = noDegreeY * Math.cos(radian) + noDegreeX * Math.sin(radian);
            
            trace(currentX,currentY,currentDegree,degreeRate)
            radian = degreeRate * Math.PI / 180;
            cos = Math.cos(radian);
            sin = Math.sin(radian);
        }
        
    }
}