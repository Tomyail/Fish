package data.pools
{
    import event.FishEvent;
    
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    
    import starling.display.Sprite;
    
    import unit.fish.BaseFish;
    
    import utils.CollisionDetection;
    import utils.Marker;
    
    public class FishPool
    {
        protected var fishMarker:Marker;
        protected var fishVector:Vector.<*>;
        protected var mainGame:MainGame
        private var index:int,j:int,k:int;
        private var fish:BaseFish;
        private var fishContainer:Sprite;
        public function FishPool()
        {
        }
        
        public function initialization(mainGame:MainGame,initNumber:Number,increaseNumber:int):void{
            this.mainGame = mainGame;
            fishContainer = new Sprite;
            mainGame.addChild(fishContainer);
            fishContainer.addEventListener(FishEvent.FISH_DIE_COMPLETE,onFishDie);
        }
        
        
        private function onFishDie(e:FishEvent):void{
//            trace("kill Fish",e.id)
            mainGame.cdm.addScore(fishVector[e.id].score);
            killFish(e.id);
        }
        
        public function addFish():BaseFish{
            index = fishMarker.getAvailableMarkIndex();
            fishMarker.addMark(index);
            fish = fishVector[index];
            fish.startSelfFly();
            mainGame.gameData.currentWeight += fish.weight;
            fishContainer.addChild(fish);
            return fish;
        }
        
        public function catchFish(bound:Rectangle):void{
            for each (k in fishMarker.marked){
                //粗范围检查
                if(!fishVector[k].toDieFlag &&fishVector[k].rangeBound.intersects(bound)){
                    //精确检查
                    if(CollisionDetection.collisionDetect(bound,0,fishVector[k].bound,fishVector[k].currentRadian) || CollisionDetection.collisionDetect(fishVector[k].bound,fishVector[k].currentRadian,bound,0)){
                        fishVector[k].toDie();
                    }
                }
            }
        }
        public function killFish(fishIndex:int):void{
            fishMarker.removeMark(fishIndex);
            fish = fishVector[index];
            fish.stopSelfFly();
            mainGame.gameData.currentWeight -= fish.weight;
            fishContainer.removeChild(fish);
        }
        public function hitTest(rangeRect:Rectangle,rect:Rectangle,radian:Number):Boolean{
            for each (j in fishMarker.marked){
                //粗范围检查
                if(!fishVector[k].toDieFlag &&fishVector[j].rangeBound.intersects(rangeRect)){
                    //精确检查
                    if(CollisionDetection.collisionDetect(rect,radian,fishVector[j].bound,fishVector[j].currentRadian) || CollisionDetection.collisionDetect(fishVector[j].bound,fishVector[j].currentRadian,rect,radian)){
                        return true;
                    }
                }
            }
            return false;
        }
        
        public function flyMarkedFish():void{
            for each (index in fishMarker.marked){
//                trace("index",index)
                fishVector[index].updateFrame();
                    
                if(fishVector[index].hasDisplayed && fishVector[index].isOutBound()){
                    killFish(index);
                }
            }
        }
        
        
    }
}