package unit.fish
{
    import event.FishEvent;
    
    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.utils.getTimer;
    
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;
    
    import unit.BaseMovieClip;
    
    public class BaseFish extends Sprite
    {
        private var str:String;
        private var radian:Number;
        private var currentDegree:Number;
        private var currentX:Number;
        private var currentY:Number;
        private var degreeRate:Number;
        private var cos:Number;
        private var sin:Number;
        private var noDegreeX:Number;
        private var noDegreeY:Number;
        private var preX:Number;
        private var preY:Number;
        private var centerX:Number;
        private var centerY:Number;
        private var rect:Rectangle;
        private var _rangeBound:Rectangle = new Rectangle;
        private var maxBounderLength:Number;
        private var mainGame:MainGame;
        
        protected var fish:MovieClip;
        protected var frames:Vector.<Texture>;
        
        
        public var hasDisplayed:Boolean = false;
        public var fishID:int;
        public var weight:int;
        public var toDieFlag:Boolean = false;
        public var score:int = 100;
        private var dieTime:int;
        private const dieDely:int = 500;
        private var fishEvent:FishEvent;
        
        private const normalFps:int = 12;
        private const speedupFps:int = 50;
        private var scoreTf:TextField;
        public function BaseFish()
        {
        }
        
        public function initialization(mainGame:MainGame,fishID:int):void{
            this.fishID = fishID;
            this.mainGame = mainGame;
            addChild(fish);
            rect = new Rectangle(0,0,fish.width,fish.height);
            maxBounderLength = (fish.width > fish.height )? fish.width:fish.height;
            _rangeBound.width = _rangeBound.height = maxBounderLength <<1;
            fishEvent = new FishEvent(FishEvent.FISH_DIE_COMPLETE,fishID,name,true);
            scoreTf = new TextField(100,50,"");
            scoreTf.color = 0xff0000;
            scoreTf.pivotX = scoreTf.width >>1;
            scoreTf.pivotY = scoreTf.height >>1;
        }
        
        public function updateFrame():void{
            if(!toDieFlag){
                preX = currentX;
                preY = currentY;
                currentX = preX * cos - preY * sin;
                currentY = preY * cos + preX * sin;
                currentDegree = Math.atan2(currentY,currentX)*180/Math.PI;
                degreeRate > 0 ? currentDegree +=180:currentDegree -= 0;
                
                fish.x = currentX + centerX;
                fish.y = currentY + centerY;
                fish.rotation = currentDegree * Math.PI/180;
                
    //            trace(fishID,isOutBound());
                if(!hasDisplayed && !isOutBound()){
    //                trace(fishID,"hasDisplayed")
                    hasDisplayed = true;
                }
    //            trace(fishID,"fly");
            }else{
                fish.alpha -= 0.05;
                scoreTf.fontSize --;
                if(mainGame.gameData.nowTime - dieTime > dieDely){
                    removeChild(scoreTf);
                    dispatchEvent(fishEvent);
                }
            }
        }
        
        public function startSelfFly():void{
            Starling.juggler.add(fish);
            fish.fps = normalFps;
            fish.alpha = 1;
            fish.play();
        }
        
        public function stopSelfFly():void{
            Starling.juggler.remove(fish);
            fish.pause();//!!
            fish.x = fish.y = -500;//let it got out of stage
        }
        
        public function toDie():void{
            toDieFlag = true;
            scoreTf.x = fish.x;
            scoreTf.y = fish.y;
            addChild(scoreTf);
            scoreTf.text = score.toString();
            scoreTf.fontSize = 30;
            fish.fps  = speedupFps;
            dieTime = getTimer();
        }
        
        /** 检查鱼是否游出边界*/
        public function isOutBound():Boolean{
            //!这里暂时这么做,不知什么原因从字典中删除的索引居然还能for each出来
            if(toDieFlag ==true){
                return false;
            }
            if(
                fish.x + fish.width < 0     ||  //left
                fish.x > stage.stageWidth   ||  //right
                fish.y + fish.height< 0     ||  //top
                fish.y > stage.stageHeight      //bottom
               )
                return true;
            return false;
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
            
//            trace(currentX,currentY,currentDegree,degreeRate)
            radian = degreeRate * Math.PI / 180;
            cos = Math.cos(radian);
            sin = Math.sin(radian);
            toDieFlag = false;
            hasDisplayed = false;
        }
        
        public function get rangeBound():Rectangle{
            _rangeBound.x = fish.x - maxBounderLength;
            _rangeBound.y = fish.y - maxBounderLength;
            return _rangeBound;
        }
        public function get bound():Rectangle{
            rect.x = fish.x;
            rect.y = fish.y;
            return rect;
        }
        
        public function get currentRadian():Number{
            return fish.rotation;
        }
    }
}