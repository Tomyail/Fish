package data.pools
{
    import unit.fish.BaseFish;
    
    import utils.Marker;
    
    public class FishPool
    {
        protected var fishMarker:Marker;
        protected var fishVector:Vector.<*>;
        protected var mainGame:MainGame
        private var index:int;
        private var birthFish:BaseFish;
        public function FishPool()
        {
        }
        
        public function initialization(mainGame:MainGame,initNumber:Number,increaseNumber:int):void{
            throw new Error("this class should override by subclass");
        }
        
        public function addFish():BaseFish{
            index = fishMarker.getAvailableMarkIndex();
            fishMarker.addMark(index);
            birthFish = fishVector[index];
            mainGame.addChild(birthFish);
            return birthFish;
        }
        
        public function killFish(fishIndex:int):void{
            fishMarker.removeMark(fishIndex);
            mainGame.removeChild(fishVector[fishIndex]);
        }
        
        public function flyMarkedFish():void{
            for each (index in fishMarker.marked){
                fishVector[index].updateFrame();
                    
                if(fishVector[index].hasDisplayed && fishVector[index].isOutBound()){
                    killFish(index);
                    trace(index,"kill")
                }
            }
        }
        
        
    }
}